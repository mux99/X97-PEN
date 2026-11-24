# Norvantec Precision — PEN course lab

Docker Compose lab environment for the grey-box engagement scenario.
**Instructor-only** — this file contains the answer key (planted
weaknesses, credentials). Don't hand it to students.

## Running it

```
docker compose build
docker compose up -d
docker compose exec kali bash
```

`kali` starts attached to the DMZ network only — that's the students'
starting foothold, matching the Session 1 "confirm connectivity to
the lab network" exercise.

Requires internet access at **build** time (pulls Debian/Alpine
packages, and `erp-legacy` specifically pulls from
`archive.debian.org` for the deliberately old Samba package). No
internet access is required or expected once the stack is running —
keep this on an isolated host/VM, not anything internet-facing.

## Topology

```
DMZ (10.60.10.0/24)            Corporate (10.60.20.0/24)
  router      .254                router     .254
  web01       .10                 dc01       .10
  mail-gw     .11                 fs01       .11
  vpn-gw      .12                 print01    .12
  kali        .50  (attacker)     jump01     .20

Production (10.60.30.0/24)     Management (10.60.40.0/24)
  router      .254                router     .254
  erp-legacy  .10                 backup01   .10
  erp-new     .11
  ftp01       .12
  qc-db       .13
```

**All inter-zone connectivity goes through the `router` container** —
a real Linux box with IP forwarding and iptables, attached to all
four networks. `kali` has static routes pointing cross-zone traffic
at it (see `services/kali/entrypoint.sh`); every other host reaches
it via NAT, so nothing else needed route changes.

**The ruleset is currently PERMISSIVE on purpose** — every zone can
reach every zone, so nothing built so far (recon, scanning, service
access) gets accidentally blocked. See
`services/router/entrypoint.sh` for exactly what to change when you
build **S12 (segmentation & defense evasion)**: swap the default
ACCEPT for a default DROP, add narrow explicit allows per intended
flow, and log the drops so evasion attempts are visible. Until then,
there's no real segmentation to defeat — just network reachability.

`vpn-gw` and `jump01` are single-homed, ordinary hosts in their own
zones now — an earlier version of this lab used them as dual-homed
"bridges," which worked but was confusing (see the conversation that
led here) and is fully superseded by the router. `jump01`'s weak SSH
login is still a real exploitation target; it just doesn't grant
network access by itself anymore, only a shell on that one box.

**Intended attack path (once the router is tightened for S12):**
`kali` (DMZ) → recon `web01`/`mail-gw` → get past the firewall into
Corporate (`fs01`, `dc01`, `print01`) → brute-force `jump01`'s weak
SSH password → from inside that shell, reach Production
(`erp-legacy`, `ftp01`, `qc-db`) and Management (`backup01`).
Right now, with the router permissive, every zone is directly
reachable from `kali` without needing to pivot through `jump01` at
all — that's expected until S12 narrows the rules back down.

## Planted weaknesses (answer key)

| Host | Weakness | Credentials / detail |
|---|---|---|
| `ftp01` | Anonymous FTP, writable | n/a |
| `ftp01` | Weak local account | `operator` / `Operator2023` |
| `fs01` | Guest/null-session SMB browsing | n/a |
| `fs01` | Weak password, reused elsewhere | `t.ricard` / `Summer2024!` |
| `erp-legacy` | Samba 4.2.x — **CVE-2017-7494 (SambaCry)** | writable guest share `ERP_Import` required for the exploit path |
| `qc-db` | Trivial DB root password | `root` / `QualityControl1` |
| `jump01` | Weak SSH password (also the pivot host) | `k.giguere` / `Fallback#2022` |

No credentials are reused across *every* host on purpose — `t.ricard`'s
password only works on `fs01`, `k.giguere`'s only on `jump01` — so
password-spraying across hosts doesn't trivially solve the whole
lab. Decide per-session whether you want to loosen that.

## Stub hosts (expand later)

`dc01`, `print01`, `backup01`, `vpn-gw` (its *service*, not its
network role — it's still single-homed in the DMZ) currently just open their
expected port with a placeholder banner (via `socat`) so they show up
correctly in Nmap/enumeration scans without being exploitable yet.
Each Dockerfile has a comment explaining what it's standing in for.
`erp-new` is a static placeholder login page — intentionally not an
exploitation target (web-app exploitation is the WEB course's lane).

`dc01` is enumeration-only on purpose: AD attacks belong to the
ADI/AUD courses later in the cursus, not PEN.

## Known limitations

- **OS fingerprinting won't lie.** `erp-legacy` runs genuinely old
  *Samba*, but the underlying container kernel is still Linux —
  `nmap -O` won't report "Windows." Service/version detection and
  banners are authentic; low-level TCP/IP stack fingerprinting isn't.
- **The router's ruleset is permissive, not absent** — there's now a
  real firewall-capable box in the path, but its policy is currently
  "allow everything." Nothing enforces segmentation yet; that's a
  deliberate, documented placeholder until S12 is built, not an
  oversight.
- `mail-gw` (smtp4dev) and `web01` expose host ports (`5000`, `8080`)
  for your own convenience inspecting them from outside Docker —
  remove those `ports:` mappings if you want the DMZ fully sealed
  from the host machine too.

USE qc_traceability;

CREATE TABLE inspections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    part_ref VARCHAR(32) NOT NULL,
    batch_ref VARCHAR(32) NOT NULL,
    inspector VARCHAR(64) NOT NULL,
    result ENUM('pass','fail','rework') NOT NULL,
    inspected_at DATETIME NOT NULL
);

INSERT INTO inspections (part_ref, batch_ref, inspector, result, inspected_at) VALUES
('GBX-HSG-4471', 'B2026-0914', 'Amy Speerstra', 'pass', '2026-09-14 08:12:00'),
('GBX-HSG-4471', 'B2026-0914', 'Amy Speerstra', 'pass', '2026-09-14 08:19:00'),
('BRK-MNT-2210', 'B2026-0915', 'Nirvana van Tienhoven', 'rework', '2026-09-15 10:02:00'),
('BRK-MNT-2210', 'B2026-0915', 'Nirvana van Tienhoven', 'pass', '2026-09-15 11:47:00'),
('CNV-PRT-0087', 'B2026-0916', 'Amy Speerstra', 'fail', '2026-09-16 09:30:00');

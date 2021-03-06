DO $$
DECLARE new_event_id UUID;
BEGIN
  INSERT INTO events VALUES
    (uuid_generate_v4(), 'Schulfest', NULL, 'Beschreibung', '2016-11-21 09:00:00.000000', '2016-11-21 18:30:00.000000',
     'e22753f6-4cb5-4009-a9e0-dbcc3ac0993b', '2016-11-18 17:20:22.704000', '2016-11-18 17:20:25.027000', 'WEEKLY', NULL,
     NULL, 1, NULL, NULL, NULL, '{MO,TH,FR}', NULL, NULL, NULL, NULL, NULL, NULL)
  RETURNING id INTO new_event_id;

  INSERT INTO alarms VALUES
    (uuid_generate_v4(), new_event_id, ';VALUE=DATE-TIME:20170101T123000Z', 2, INTERVAL '15 mins', 'DISPLAY', NULL,
      'Testanzeige', NULL, NULL);

  INSERT INTO events VALUES
    (uuid_generate_v4(), 'Exkursion', 'HPI, Potsdam', NULL, '2016-11-22 09:00:00.000000', '2016-11-23 18:30:00.000000',
     '8b0753ab-6fa8-4f42-80bd-700fe8f7d66d', NOW(), NOW(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
      NULL, NULL, NULL, NULL),
    (uuid_generate_v4(), 'Termin, der JETZT stattfindet', 'Berlin', NULL, NOW(), NOW(),
     '8b0753ab-6fa8-4f42-80bd-700fe8f7d66d', NOW(), NOW(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
      NULL, NULL, NULL, NULL),
    (uuid_generate_v4(), 'Termin den keiner besuchen darf', 'HPI, Potsdam', NULL, '2016-11-22 09:00:00.000000',
     '2016-11-23 18:30:00.000000', '8b0753ab-6fa8-4f42-80bd-700fe8f7d66f', NOW(), NOW(), NULL, NULL, NULL, NULL, NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    (uuid_generate_v4(), 'user scope description', 'user scope name', NULL, '2016-11-22 09:00:00.000000',
     '2016-11-23 18:30:00.000000', '59898b4a26ffc20c510cfcf0', NOW(), NOW(), NULL, NULL, NULL, NULL, NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    (uuid_generate_v4(), 'class read scope description', 'class read scope name', NULL, '2020-01-07 09:00:00.000000',
     '2016-11-23 18:30:00.000000', '5db838ff8517be0028847d1d', NOW(), NOW(), NULL, NULL, NULL, NULL, NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    (uuid_generate_v4(), 'class write scope description', 'class write scope name', NULL, '2020-01-07 09:00:00.000000',
     '2016-11-23 18:30:00.000000', '5d63d2738e9031001a53f82f', NOW(), NOW(), NULL, NULL, NULL, NULL, NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    (uuid_generate_v4(), 'course read scope description', 'course read scope name', NULL, '2020-01-07 09:00:00.000000',
     '2016-11-23 18:30:00.000000', '58f735e4014bbf45f0be2502', NOW(), NOW(), NULL, NULL, NULL, NULL, NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
    (uuid_generate_v4(), 'course write scope description', 'course write scope name', NULL, '2020-01-07 09:00:00.000000',
     '2016-11-23 18:30:00.000000', '5b51d6a582cf210011bedcb1', NOW(), NOW(), NULL, NULL, NULL, NULL, NULL,
      NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

  INSERT INTO exdates VALUES
    (uuid_generate_v4(), new_event_id, '2016-11-21 09:00:00.000000');

  INSERT INTO subscriptions VALUES
    (uuid_generate_v4(), 'https://calendars.icloud.com/holidays/de_de.ics', 'Public Holidays in Germany',
        '2017-01-23T10:00:00Z', 200, 'e22753f6-4cb5-4009-a9e0-dbcc3ac0993b'),
    (uuid_generate_v4(), 'invalid-url', 'Calendar That Cannot be Fetched', '2017-01-23T10:00:00Z', 500,
        '874a9be4-ea6a-4364-852d-1a46b0d155f3');
END $$;

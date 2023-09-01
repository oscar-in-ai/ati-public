INSERT INTO `configuration_parameters`
(`terminal_id`,
`parameter_name`,
`parameter_value`,
`parameter_type`,
`start_dt`,
`end_dt`)
SELECT 
4,
`parameter_name`,
`parameter_value`,
`parameter_type`,
`start_dt`,
`end_dt`
FROM `configuration_parameters`
WHERE terminal_id = 7
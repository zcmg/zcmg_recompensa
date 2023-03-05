DROP TABLE IF EXISTS `zcmg_recompensa`;
CREATE TABLE IF NOT EXISTS `zcmg_recompensa` (
  `code` text DEFAULT NULL,
  `type` text DEFAULT NULL,
  `data1` text DEFAULT NULL,
  `data2` text DEFAULT NULL,
  `owner` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `zcmg_recompensa_admins`;
CREATE TABLE IF NOT EXISTS `zcmg_recompensa_admins` (
  `identifier` varchar(46) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `group_admin` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `recompensa`;
CREATE TABLE `recompensa` (
  `code` text DEFAULT NULL,
  `type` text DEFAULT NULL,
  `data1` text DEFAULT NULL, 
  `data2` text DEFAULT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
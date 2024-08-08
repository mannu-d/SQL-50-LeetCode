SELECT Wtr.id
FROM Weather AS Wtr
INNER JOIN Weather AS Wthr
  ON (DATE_SUB(Wtr.recordDate, INTERVAL 1 DAY) = Wthr.recordDate)
WHERE Wtr.temperature > Wthr.temperature;
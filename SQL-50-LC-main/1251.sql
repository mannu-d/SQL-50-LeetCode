select p.product_id ,  COALESCE(ROUND(sum(p.price*us.units)/sum(units),2),0) as average_price
from Prices p
LEFT JOIN UnitsSold us
ON p.product_id=us.product_id AND us.purchase_date between p.start_date and p.end_date
group by 1;
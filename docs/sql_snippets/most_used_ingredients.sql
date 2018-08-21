SELECT product_ingredients.name, pi_usage.occurences
FROM ( SELECT product_ingredient_id, count(product_ingredient_id) AS occurences
       FROM products_product_ingredients
       GROUP BY product_ingredient_id
     ) AS pi_usage
INNER JOIN product_ingredients ON pi_usage.product_ingredient_id = product_ingredients.id
ORDER BY pi_usage.occurences DESC;

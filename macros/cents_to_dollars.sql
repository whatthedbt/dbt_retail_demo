{#Retail data often stores prices as integers (cents) to avoid rounding issues. 
This macro safely converts them to standard decimal dollar amounts.#}

{% macro cents_to_dollars(column_name, decimal_places=2) -%}
    round(cast({{ column_name }} as numeric), {{ decimal_places }})
{%- endmacro %}

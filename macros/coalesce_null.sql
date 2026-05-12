{% macro coalesce_null(col, default='Unknown') -%}
    coalesce({{col}}, {{default}})
{%- endmacro %}
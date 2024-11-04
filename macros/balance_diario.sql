{% macro balance_acumulado(column_name) %}
   
    sum({{ column_name }})
   
{% endmacro %}



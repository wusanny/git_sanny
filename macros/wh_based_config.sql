{%- macro wh_based_config_incremental(wh_size=none) %}

    {% set runtime_value = var('full_refresh_warehouse', none) %}

    {% if runtime_value is not none and runtime_value != 'dummy_wh' %}
        use warehouse {{ runtime_value }}
    {% endif %}    

{% endmacro -%}
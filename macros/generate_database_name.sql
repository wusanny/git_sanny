% macro generate_database_name(custom_database_name, node) -%}

    {%- set default_database = target.database -%}

    {%- if (target.name == 'ci') -%}

        {{ custom_database_name }}

    {%- else -%}

        {{ default_database }}

    {%- endif -%}

{%- endmacro %}
{% macro generate_alias_name(custom_alias_name=none, node=none) -%}

    {%- if custom_alias_name is none -%}

        {% set tier_folder_name = node.fqn[1] %}
        {% set function_folder_name = node.fqn[2] %}
        {% set model_name = node.name %}
        {% set schema_name = node.config.get('schema') %}

        {#
            2. Generate the alias name based on the target name.
                (1) For "deploy" target:
                    Use the model name as the table name
                    Examples:
                        a. <schema>.client_private_api_crud_requests
                        b. <schema>.marketing_contribution
                        b. <schema>.adv_filter_use_by_base_day
                (2) For "dev", "development", "default", "ci" targets:
                    The table name is prefixed with the tier/function folder name, and suffixed with value of env "DBT_DEV_TABLE_SUFFIX"
                    Examples:
                        a. ds_dev.<schema>__client_private_api_crud_requests{DBT_DEV_TABLE_SUFFIX}
                        b. ds_dev.<schema>__marketing_contribution{DBT_DEV_TABLE_SUFFIX}
                        b. ds_dev.<schema>__adv_filter_use_by_base_day{DBT_DEV_TABLE_SUFFIX}
                (3) For all other targets, raise an error
        #}
        {% if target.name == 'deploy' %}
            {% set destination_model_name = model_name -%}
        {% elif target.name == 'dev' or target.name == 'development' or target.name == 'default' or target.name == 'ci' %}
            {% set destination_model_name = schema_name ~ '__' ~ model_name -%}
        {% else %}
            {% do exceptions.warn("Invalid `target` in generate_alias_name macro. Got: " ~ target.name) %}
        {% endif %}
    {%- else -%}
        {% set destination_model_name = custom_alias_name | trim -%}
    {%- endif -%}

    {{ log("model " ~ node.fqn[1:] ~ " will be created as: " ~ destination_model_name, info=True) }}
    {{ destination_model_name }}

{%- endmacro %}
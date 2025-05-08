{% macro grant_permissions() %}
  {% if this.schema.endswith('data_mart') or this.schema.endswith('reporting') %}
    grant select on "{{ this.schema }}"."{{ this.table }}" to tableau_readonly;
  {% endif %}

  {% if env_var('DBT_CLOUD_ENVIRONMENT_TYPE', '') == 'prod' %}
    grant select on "{{ this.schema }}"."{{ this.table }}" to group data_team;
  {% else %}
    grant all on "{{ this.schema }}"."{{ this.table }}" to group data_team;
  {% endif %}
{% endmacro %}
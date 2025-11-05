create database if not exists cortex_lab_db;
create schema if not exists cortex_lab_db.risk_data;

CREATE DATABASE IF NOT EXISTS snowflake_intelligence;
CREATE SCHEMA IF NOT EXISTS snowflake_intelligence.agents;

GRANT USAGE ON DATABASE snowflake_intelligence TO ROLE ATTENDEE_ROLE;
GRANT USAGE ON SCHEMA snowflake_intelligence.agents TO ROLE ATTENDEE_ROLE;

CREATE OR REPLACE WAREHOUSE Snow_Intelligence_demo_wh 
    WITH WAREHOUSE_SIZE = 'XSMALL'
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE;


GRANT USAGE ON WAREHOUSE SNOW_INTELLIGENCE_DEMO_WH TO ROLE ATTENDEE_ROLE;

CREATE OR REPLACE NETWORK RULE Snowflake_intelligence_WebAccessRule
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('0.0.0.0:80', '0.0.0.0:443');


CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION Snowflake_intelligence_ExternalAccess_Integration
ALLOWED_NETWORK_RULES = (Snowflake_intelligence_WebAccessRule)
ENABLED = true;

CREATE OR REPLACE NOTIFICATION INTEGRATION ai_email_int
  TYPE=EMAIL
  ENABLED=TRUE;

GRANT DATABASE ROLE SNOWFLAKE.PYPI_REPOSITORY_USER TO ROLE attendee_role;

use schema CORTEX_LAB_DB.RISK_DATA;
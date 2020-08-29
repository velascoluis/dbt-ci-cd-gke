FROM fishtownanalytics/dbt:0.17.0rc4
ENV DBT_PROFILES_DIR=/dbt/profile/
ENV PROJECT_ID=velascoluis-test
COPY profiles.yml /dbt/profile/
COPY keyfile.json /dbt
COPY dbtexp /dbt
USER root
RUN chown -R dbt_user /dbt
USER dbt_user
WORKDIR /dbt
RUN dbt run

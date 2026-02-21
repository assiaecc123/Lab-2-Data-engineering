import duckdb
conn = duckdb.connect('playstore.duckdb')
result = conn.execute("""
    SELECT app_id, valid_from, valid_to, is_current 
    FROM dim_apps_scd 
    WHERE app_id = 'com.google.android.apps.labs.language.tailwind' 
    ORDER BY valid_from
""").fetchdf()
print(result)

import json, os, sys

RAW_FILE = os.path.join("raw_data", "apps_catalog.json")

def main():
    if not os.path.exists(RAW_FILE):
        print(f"ERROR: Could not find {RAW_FILE}")
        sys.exit(1)
    with open(RAW_FILE, "r", encoding="utf-8") as f:
        content = f.read().strip()
    if content.startswith("["):
        apps = json.loads(content)
        is_array = True
    else:
        apps = [json.loads(line) for line in content.splitlines() if line.strip()]
        is_array = False
    target = apps[0]
    app_id = target.get("appId", "unknown")
    app_name = target.get("title", "unknown")
    old_category = target.get("genre", "unknown")
    new_category = old_category + "_MODIFIED"
    print(f"App: {app_name} ({app_id})")
    print(f"Old category: {old_category} -> {new_category}")
    apps[0]["genre"] = new_category
    with open(RAW_FILE, "w", encoding="utf-8") as f:
        if is_array:
            json.dump(apps, f, indent=2, ensure_ascii=False)
        else:
            for app in apps:
                f.write(json.dumps(app, ensure_ascii=False) + "\n")
    print("Done. Now run: dbt snapshot, then dbt run")

if __name__ == "__main__":
    main()

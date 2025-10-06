import json, os
TABLE = os.environ.get("TABLE_NAME")
def handler(event, context):
    return {"statusCode":200,"body":json.dumps({"ok":True,"icu_beds":42,"med_surge_beds":100})}

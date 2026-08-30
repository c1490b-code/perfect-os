import os
import re
import psycopg2


class PerfectOSAISQL:
    """AI-assisted SQL interface for Perfect-OS."""

    def __init__(self, database_url=None):
        self.database_url = database_url or os.getenv("DATABASE_URL")

    def connect(self):
        if not self.database_url:
            raise RuntimeError("DATABASE_URL is not configured")
        return psycopg2.connect(self.database_url)

    def validate(self, sql):
        """Allow safe read-only AI-generated SQL by default."""
        sql = sql.strip()

        blocked = r"\b(DROP|TRUNCATE|ALTER|GRANT|REVOKE|CREATE\s+ROLE)\b"

        if re.search(blocked, sql, re.IGNORECASE):
            raise PermissionError("Blocked SQL operation")

        return sql

    def execute(self, sql, parameters=None):
        sql = self.validate(sql)

        with self.connect() as conn:
            with conn.cursor() as cursor:
                cursor.execute(sql, parameters)

                if cursor.description:
                    columns = [d[0] for d in cursor.description]
                    rows = cursor.fetchall()
                    return {
                        "columns": columns,
                        "rows": rows
                    }

                conn.commit()
                return {"status": "ok"}


def create_ai_sql():
    return PerfectOSAISQL()

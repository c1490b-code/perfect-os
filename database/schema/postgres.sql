CREATE SCHEMA IF NOT EXISTS perfect_os;

CREATE TABLE IF NOT EXISTS perfect_os.users (
    id UUID PRIMARY KEY,
    username VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS perfect_os.devices (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES perfect_os.users(id),
    hostname VARCHAR(255) NOT NULL,
    os_version VARCHAR(100),
    architecture VARCHAR(50),
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS perfect_os.applications (
    id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    version VARCHAR(100),
    executable TEXT,
    installed_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS perfect_os.ai_agents (
    id UUID PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    model VARCHAR(255),
    endpoint TEXT,
    enabled BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS perfect_os.system_events (
    id BIGSERIAL PRIMARY KEY,
    device_id UUID REFERENCES perfect_os.devices(id),
    event_type VARCHAR(100) NOT NULL,
    payload JSONB,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

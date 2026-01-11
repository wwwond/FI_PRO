-- 추후 ERD 설계후 넣을 예정

CREATE TABLE "life_stage_explain" (
	"explain_id"	BIGSERIAL		NOT NULL,
	"life_stage_pred_id"	BIGSERIAL		NOT NULL,
	"method"	VARCHAR(20)		NOT NULL,
	"feature_name"	VARCHAR(200)		NOT NULL,
	"contribution"	NUMERIC(18,6)		NULL,
	"rank_no"	INTEGER		NOT NULL,
	"evidence_text"	TEXT		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL
);

CREATE TABLE "spend_category_quarter" (
	"spend_category_quarter_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"bas_yh"	CHAR(6)		NOT NULL,
	"category_lv"	VARCHAR(10)		NOT NULL,
	"major_code"	VARCHAR(50)		NOT NULL,
	"middle_code"	VARCHAR(50)		NULL,
	"amount"	NUMERIC(18,2)		NOT NULL,
	"ratio"	NUMERIC(8,5)		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL
);

CREATE TABLE "oauth_account" (
	"oauth_account_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"provider"	VARCHAR(20)		NOT NULL,
	"provider_user_id"	VARCHAR(255)		NOT NULL,
	"email_at_provider"	VARCHAR(255)		NULL,
	"linked_at"	TIMESTAMPTZ		NOT NULL,
	"unlinked_at"	TIMESTAMPTZ		NULL,
	"UNIQUE(provider,"	provider_user_id)		NULL
);

CREATE TABLE "dashboard" (
	"dashboard_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"bas_yh"	CHAR(6)		NOT NULL,
	"total_spend"	NUMERIC(18,2)		NULL,
	"credit_spend"	NUMERIC(18,2)		NULL,
	"check_spend"	NUMERIC(18,2)		NULL,
	"top1"	VARCHAR(50)		NULL,
	"top2"	VARCHAR(50)		NULL,
	"top3"	VARCHAR(50)		NULL,
	"prev_total_spend"	NUMERIC(18,2)		NULL,
	"delta_pct"	NUMERIC(10,4)		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL,
	"UNIQUE(user_id,"	bas_yh)		NULL
);

CREATE TABLE "auth_session" (
	"session_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"refresh_token_hash"	TEXT		NOT NULL,
	"issued_at"	TIMESTAMPTZ		NOT NULL,
	"expires_at"	TIMESTAMPTZ		NOT NULL,
	"revoked_at"	TIMESTAMPTZ		NULL,
	"revoke_reason"	TEXT		NULL,
	"created_ip"	INET		NULL,
	"user_agent"	TEXT		NULL
);

CREATE TABLE "life_stage_feedback" (
	"feedback_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"life_stage_pred_id"	BIGSERIAL		NOT NULL,
	"bas_yh"	CHAR(6)		NOT NULL,
	"predicted_label"	VARCHAR(50)		NULL,
	"corrected_label"	VARCHAR(50)		NOT NULL,
	"reason_text"	TEXT		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL
);

CREATE TABLE "user_role" (
	"user_id"	BIGINT		NOT NULL,
	"role_id"	SMALLINT		NOT NULL
);

CREATE TABLE "customer_spend" (
	"customer_spend_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"bas_yh"	CHAR(6)		NOT NULL,
	"base_point"	CHAR(6)		NOT NULL,
	"consumption_area"	CHAR(40)		NOT NULL,
	"age"	CHAR(2)		NOT NULL,
	"gender"	CHAR(2)		NOT NULL,
	"mem_grade"	CHAR(2)		NOT NULL,
	"enrollment_date"	CHAR(6)		NOT NULL,
	"residence"	CHAR(40)		NOT NULL,
	"DCSS"	VARCHAR(2)		NOT NULL,
	"MCSS"	VARCHAR(2)		NOT NULL,
	"total_spend"	NUMERIC(18,2)		NULL,
	"credit_spend"	NUMERIC(18,2)		NULL,
	"check_spend"	NUMERIC(18,2)		NULL,
	"cat_hfk"	DEC(18)		NULL,
	"cat_ih"	DEC(18)		NULL,
	"cat_ocba"	DEC(18)		NULL,
	"cat_trc"	DEC(18)		NULL,
	"cat_rb"	DEC(18)		NULL,
	"cat_srb"	DEC(18)		NULL,
	"cat_d"	DEC(18)		NULL,
	"cat_hh"	DEC(18)		NULL,
	"cat_cpm"	DEC(18)		NULL,
	"cat_afm"	DEC(18)		NULL,
	"cat_f"	DEC(18)		NULL,
	"cat_ha"	DEC(18)		NULL,
	"cat_hf"	DEC(18)		NULL,
	"cat_bfm"	DEC(18)		NULL,
	"cat_com"	DEC(18)		NULL,
	"cat_op"	DEC(18)		NULL,
	"cat_aff"	DEC(18)		NULL,
	"cat_le"	DEC(18)		NULL,
	"cat_ls"	DEC(18)		NULL,
	"cat_ch"	DEC(18)		NULL,
	"hs"	DEC(18)		NULL,
	"cat_i"	DEC(18)		NULL,
	"cat_oc"	DEC(18)		NULL,
	"cat_bp"	DEC(18)		NULL,
	"cat_rs"	DEC(18)		NULL,
	"cat_li"	DEC(18)		NULL,
	"cat_pmg"	DEC(18)		NULL,
	"cat_tti"	DEC(18)		NULL,
	"cat_fs"	DEC(18)		NULL,
	"cat_ss"	DEC(18)		NULL,
	"cat_ndi"	DEC(18)		NULL,
	"cat_fdi"	DEC(18)		NULL,
	"cat_fb"	DEC(18)		NULL,
	"cat_hosp"	DEC(18)		NULL,
	"cat_c"	DEC(18)		NULL,
	"cat_rr"	DEC(18)		NULL,
	"cat_mma"	DEC(18)		NULL,
	"cat_cs"	DEC(18)		NULL,
	"cat_k"	DEC(18)		NULL,
	"cat_t"	DEC(18)		NULL,
	"cat_a"	DEC(18)		NULL,
	"cat_mtbe"	DEC(18)		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL
);

CREATE TABLE "health_scores" (
	"health_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"bas_yh"	CHAR(6)		NOT NULL,
	"total_score"	INTEGER		NULL,
	"grade"	CHAR(1)		NOT NULL,
	"credit_ratio"	NUMERIC(8,5)		NULL,
	"spending_focus"	NUMERIC(8,5)		NULL,
	"risk_cat_ratio"	NUMERIC(8,5)		NULL,
	"surge_pattern"	NUMERIC(8,5)		NULL,
	"ml_score"	NUMERIC(6,2)		NULL,
	"ml_grade"	CHAR(1)		NULL,
	"ml_model_version"	VARCHAR(50)		NULL,
	"raw_metrics"	JSONB		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL,
	"UNIQUE(user_id,"	bas_yh)		NULL
);

CREATE TABLE "login_history" (
	"login_history_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"oauth_account_id"	BIGINT		NULL,
	"provider"	VARCHAR(20)		NULL,
	"result"	VARCHAR(10)		NOT NULL,
	"fail_reason"	VARCHAR(30)		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL
);

CREATE TABLE "import_errors" (
	"import_errors_id"	BIGSERIAL		NOT NULL,
	"import_jobs_id"	BIGSERIAL		NOT NULL,
	"row_number"	BIGINT		NULL,
	"column_name"	VARCHAR(200)		NULL,
	"error_code"	VARCHAR(50)		NULL,
	"error_message"	TEXT		NOT NULL,
	"raw_value"	TEXT		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL
);

CREATE TABLE "role" (
	"role_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"role_key"	VARCHAR(20)		NOT NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL,
	"updated_at"	TIMESTAMPTZ		NULL
);

CREATE TABLE "health_score_components" (
	"component_id"	BIGSERIAL		NOT NULL,
	"health_id"	BIGSERIAL		NOT NULL,
	"component_key"	VARCHAR(50)		NOT NULL,
	"weight"	NUMERIC(10,6)		NULL,
	"metric_value"	NUMERIC(18,6)		NULL,
	"component_score"	NUMERIC(6,2)		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL,
	"UNIQUE(health_id,"	component_key)		NULL
);

CREATE TABLE "dim_quarter" (
	"dim_quarter"	CHAR(6)		NOT NULL,
	"year"	INTEGER		NULL,
	"half_q"	INTEGER		NULL,
	"CHECK"	(bas_yh ~ '^0-9{6}$')		NULL
);

CREATE TABLE "notification_logs" (
	"notification_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"ref_type"	VARCHAR(30)		NULL,
	"ref_id"	BIGINT		NULL,
	"type"	VARCHAR(20)		NOT NULL,
	"title"	VARCHAR(100		NULL
);

CREATE TABLE "fds_scores" (
	"fds_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"bas_yh"	CHAR(6)		NOT NULL,
	"anomaly_score"	NUMERIC(12,6)		NOT NULL,
	"detect_reason"	TEXT		NULL,
	"is_confirmed"	BOOLEAN		NULL,
	"raw_data_ref"	JSONB		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL,
	"UNIQUE(user_id,"	bas_yh)		NULL
);

CREATE TABLE "import_jobs" (
	"import_jobs_id"	BIGSERIAL		NOT NULL,
	"started_by"	BIGINT		NULL,
	"source_name"	VARCHAR(200)		NOT NULL,
	"target_table"	VARCHAR(200)		NOT NULL,
	"bas_yh"	CHAR(6)		NULL,
	"status"	VARCHAR(20)		NOT NULL,
	"failed))"	DEFAULT	DEFAULT 'queued'	NULL,
	"row_count"	BIGINT		NULL,
	"started_at"	TIMESTAMPTZ		NOT NULL,
	"finished_at"	TIMESTAMPTZ		NULL,
	"message"	TEXT		NULL
);

COMMENT ON COLUMN "import_jobs"."started_by" IS 'user_id를 참조해야하지 않을까요?';

CREATE TABLE "quarter_summaries" (
	"summary_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"bas_yh"	CHAR(6)		NOT NULL,
	"tot_delta_pct"	NUMERIC(10,4)		NULL,
	"top_change_json"	JSONB		NULL,
	"health_delta"	NUMERIC(10,4)		NULL,
	"life_stage_changed"	BOOLEAN		NULL,
	"summary_text"	TEXT		NOT NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL,
	"UNIQUE(user_id,"	bas_yh)		NULL
);

CREATE TABLE "fds_reasons" (
	"fds_reason_id"	BIGSERIAL		NOT NULL,
	"fds_id"	BIGSERIAL		NOT NULL,
	"reason_code"	VARCHAR(50)		NOT NULL,
	"metric_name"	VARCHAR(200)		NULL,
	"metric_value"	NUMERIC(18,6)		NULL,
	"baseline_value"	NUMERIC(18,6)		NULL,
	"delta_value"	NUMERIC(18,6)		NULL,
	"detail_text"	TEXT		NULL,
	"rank_no"	INTEGER		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL
);

CREATE TABLE "app_user" (
	"user_id"	BIGSERIAL		NOT NULL,
	"email"	VARCHAR(255)		NOT NULL,
	"password_hash"	TEXT		NOT NULL,
	"status"	VARCHAR(20)		NOT NULL,
	"LOCKED))"	DEFAULT	DEFAULT 'ACTIVE'	NULL,
	"display_name"	VARCHAR(50)		NOT NULL,
	"failed_login_count"	INTEGER		NOT NULL,
	"last_failed_at"	TIMESTAMPTZ		NULL,
	"locked_until"	TIMESTAMPTZ		NULL,
	"last_login_at"	TIMESTAMPTZ		NULL,
	"life_stage_cached"	VARCHAR(50)		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL,
	"updated_at"	TIMESTAMPTZ		NOT NULL
);

CREATE TABLE "life_stage_pred" (
	"life_stage_pred_id"	BIGSERIAL		NOT NULL,
	"user_id"	BIGSERIAL		NOT NULL,
	"bas_yh"	CHAR(6)		NOT NULL,
	"model_version"	VARCHAR(50)		NOT NULL,
	"predicted_label"	VARCHAR(50)		NOT NULL,
	"top3_json"	JSONB		NOT NULL,
	"confidence_level"	VARCHAR(10)		NULL,
	"created_at"	TIMESTAMPTZ		NOT NULL,
	"UNIQUE(user_id,"	bas_yh,		NULL
);

ALTER TABLE "life_stage_explain" ADD CONSTRAINT "PK_LIFE_STAGE_EXPLAIN" PRIMARY KEY (
	"explain_id"
);

ALTER TABLE "spend_category_quarter" ADD CONSTRAINT "PK_SPEND_CATEGORY_QUARTER" PRIMARY KEY (
	"spend_category_quarter_id"
);

ALTER TABLE "oauth_account" ADD CONSTRAINT "PK_OAUTH_ACCOUNT" PRIMARY KEY (
	"oauth_account_id"
);

ALTER TABLE "dashboard" ADD CONSTRAINT "PK_DASHBOARD" PRIMARY KEY (
	"dashboard_id"
);

ALTER TABLE "auth_session" ADD CONSTRAINT "PK_AUTH_SESSION" PRIMARY KEY (
	"session_id"
);

ALTER TABLE "life_stage_feedback" ADD CONSTRAINT "PK_LIFE_STAGE_FEEDBACK" PRIMARY KEY (
	"feedback_id"
);

ALTER TABLE "user_role" ADD CONSTRAINT "PK_USER_ROLE" PRIMARY KEY (
	"user_id",
	"role_id"
);

ALTER TABLE "customer_spend" ADD CONSTRAINT "PK_CUSTOMER_SPEND" PRIMARY KEY (
	"customer_spend_id"
);

ALTER TABLE "health_scores" ADD CONSTRAINT "PK_HEALTH_SCORES" PRIMARY KEY (
	"health_id"
);

ALTER TABLE "login_history" ADD CONSTRAINT "PK_LOGIN_HISTORY" PRIMARY KEY (
	"login_history_id"
);

ALTER TABLE "import_errors" ADD CONSTRAINT "PK_IMPORT_ERRORS" PRIMARY KEY (
	"import_errors_id"
);

ALTER TABLE "role" ADD CONSTRAINT "PK_ROLE" PRIMARY KEY (
	"role_id"
);

ALTER TABLE "health_score_components" ADD CONSTRAINT "PK_HEALTH_SCORE_COMPONENTS" PRIMARY KEY (
	"component_id"
);

ALTER TABLE "dim_quarter" ADD CONSTRAINT "PK_DIM_QUARTER" PRIMARY KEY (
	"dim_quarter"
);

ALTER TABLE "notification_logs" ADD CONSTRAINT "PK_NOTIFICATION_LOGS" PRIMARY KEY (
	"notification_id"
);

ALTER TABLE "fds_scores" ADD CONSTRAINT "PK_FDS_SCORES" PRIMARY KEY (
	"fds_id"
);

ALTER TABLE "import_jobs" ADD CONSTRAINT "PK_IMPORT_JOBS" PRIMARY KEY (
	"import_jobs_id"
);

ALTER TABLE "quarter_summaries" ADD CONSTRAINT "PK_QUARTER_SUMMARIES" PRIMARY KEY (
	"summary_id"
);

ALTER TABLE "fds_reasons" ADD CONSTRAINT "PK_FDS_REASONS" PRIMARY KEY (
	"fds_reason_id"
);

ALTER TABLE "app_user" ADD CONSTRAINT "PK_APP_USER" PRIMARY KEY (
	"user_id"
);

ALTER TABLE "life_stage_pred" ADD CONSTRAINT "PK_LIFE_STAGE_PRED" PRIMARY KEY (
	"life_stage_pred_id"
);

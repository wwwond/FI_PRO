FI_PRO

AI 기반 소비 분석 · 라이프스테이지 진단 · 금융 추천 플랫폼 (B2B2C)

1. 프로젝트 개요 
FI_PRO는 카드사 소비 데이터를 기반으로
개인 고객에게는 소비 인사이트·건강도·추천을 제공하고,
카드사에는 AI 분석 결과를 서비스로 연결하는 B2B2C 금융 AI 플랫폼

++++
그 엑셀파일은 무거워서 안올라가져서 각자 다운받아서 
data/raw안에 직접 넣으세여

++++
이거 clone에서 받고 올릴 때 branch파서 올리세여


2) 전체 폴더/파일 의미와 목적
A. 최상위 FI_PRO/
README.md: 프로젝트 소개, 실행방법, 데이터 적재/학습/서빙 흐름 설명
.env: 로컬 환경변수(비밀값 포함 가능 → 깃 제외)
.gitignore: 데이터/outputs/모델파일 등 제외
docker-compose.yml: DB + 백엔드 + nginx(있으면) 통합 실행

B. data/ (프로젝트 공용 데이터)
data/raw/: 원본 데이터(수정 금지)
edu_data_F.csv: 원본/실험용 데이터 파일
우리 fisa 3기...xlsx: 데이터 명세/정의서
data/processed/: 전처리/피처 생성 결과(학습 입력/검증용)
data/db_seed/: DB에 넣기 좋은 형태로 정리한 CSV
customer_quarter.csv: 분기별 고객 집계 데이터 seed
중요한 점: raw=원본 보존, processed= 가공 결과, db_seed= DB 적재용

C. infra/ (배포/운영)
infra/nginx/default.conf: nginx 리버스 프록시 설정(선택)
infra/scripts/init_db.sh: DB 초기화(테이블/권한/확장 등)
infra/scripts/import_dataset.sh: seed 데이터 적재 실행 스크립트
infra/scripts/seed_admin.sql: 관리자 계정 생성 SQL
infra/scripts/seed_products.sql: 상품 더미데이터 초기 적재 SQL

D. ml_pipeline/ (학습 파이프라인: AI 개발자 중심)
ml_pipeline/src/data/
load_raw.py: raw/processed 파일 읽기
clean.py: 결측치/형변환/코드값 정규화
split.py: 학습/검증 분리
export_seed.py: 학습용 가공결과를 db_seed로 내보내기(필요시)

ml_pipeline/src/features/
build_features.py: 모델 입력 피처 생성(비율, 증감률, 카테고리 합계 등)
encoders.py: 인코딩/스케일링(라벨인코더, 원핫, 스케일러 등)

ml_pipeline/src/train/
train_lifestage.py: 라이프스테이지 분류 모델 학습/저장
train_anomaly.py: 이상치/패턴 탐지 모델 학습/저장
train_clustering.py: 군집/유사도용 임베딩/클러스터링 학습/저장
train_health_score.py: 건강도(회귀/분류) 모델 또는 룰 보정 학습

ml_pipeline/src/evaluate/
metrics.py: 성능지표 계산(accuracy, f1 등)
calibration.py: 확률 보정/신뢰도 레벨(선택)
explainability.py: 중요 피처/설명(perm/shap 등)

ml_pipeline/src/report/
model_report_generator.py: 모델 성능 리포트 자동 생성(포폴에서 강점)

ml_pipeline/notebooks/
00_data_check.ipynb: 데이터 확인
01_eda.ipynb: EDA
02_feature_engineering.ipynb: 피처 실험
03~07...ipynb: 각 모델 학습/평가 리포트

ml_pipeline/outputs/
학습 산출물(모델/리포트/그래프)

E. backend/ (서빙/운영: 백엔드 중심)
1) backend/alembic/
env.py: Alembic 마이그레이션 설정
versions/: DB 스키마 변경 이력

2) backend/app/core/
config.py: 환경변수/설정 로딩
constants.py: 코드값/고정 상수
logging.py: 로그 포맷/요청ID/핸들러
rate_limit.py: 로그인 실패 제한 등
security.py: JWT/패스워드 해시/권한 체크

3) backend/app/db/
base.py: SQLAlchemy Base
session.py: DB 세션 생성/관리

seed/
import_customer_quarter.py: customer_quarter.csv DB 적재 코드
import_products.py: 상품 데이터 적재 코드

4) backend/app/models/ (DB ORM 모델)
user.py: 사용자 테이블
user_setting.py: 사용자 기본 설정(비교집단/기본분기 등)
customer_quarter.py: 분기별 고객 집계 테이블(핵심)
product.py: 상품 카탈로그
recommendation_log.py: 추천 결과 로그(설명/추적)
report_cache.py: 대시보드/요약 캐시(선택)
lifestage_feedback.py: 사용자 정정/피드백 저장
model_registry.py: 모델 버전/파일경로/성능 메타 저장(선택)
notification.py: 알림 저장(확장)

5) backend/app/schemas/ (Pydantic DTO)
각 API 요청/응답 스키마
auth.py, user.py, dashboard.py ...

6) backend/app/services/ (비즈니스 로직)
analytics/
dashboard_service.py: 대시보드 계산
compare_service.py: 비교집단 계산
data_quality_service.py: 품질 리포트 계산
feature_engineering.py: 서빙용 피처 생성(ML과 계약 중요)

importer/
dataset_reader.py: seed 파일 읽기
validator.py: 컬럼/타입 검증
normalizer.py: 코드/지역 정규화
loader.py: DB 적재 실행

lifestage/
predictor.py: 라이프스테이지 예측 호출
feedback_service.py: 피드백 저장/반영

scoring/
health_score_service.py: 건강도 점수 계산(룰/ML)
loan_risk_service.py: 소비 기반 위험도 계산

fds/
anomaly_rules.py: 룰 기반 탐지
isolation_forest.py: 모델 기반 anomaly score

clustering/
embedder.py: 벡터 생성 로직
cluster_service.py: 군집 결과 제공
similarity_service.py: 유사 사용자 검색

recommendation/
catalog_service.py: 상품 조회/필터
rule_recommender.py: 룰 추천
cluster_recommender.py: 군집 기반 추천

summary/
quarter_summary.py: 분기 요약 생성(템플릿/LLM)

7) backend/app/ml/ (서빙용 ML)

artifacts/
lifestage/, anomaly/, clustering/, health_score_model/
학습된 모델 파일 저장(예: model.pkl, scaler.pkl 등)

contracts/
feature_schema.json: 입력 피처 계약(서빙/학습 일치)
model_card.md: 모델 설명/제약/학습 데이터 범위

loaders/
lifestage_loaders.py 등: 모델 파일 로딩/검증/캐싱

8) backend/app/api/
router.py: v1 라우터 묶기
v1/*.py: 엔드포인트 정의(입력→서비스 호출→응답)
auth.py: 회원/토큰
users.py: 프로필/설정
dashboard.py: 대시보드
compare.py: 비교
lifestage.py: 라이프스테이지
health_score.py: 건강도
fds.py: 이상 패턴
recommend.py: 추천
summary.py: 분기 요약
data_quality.py: 품질 리포트
import_admin.py: 관리자 적재
admin.py: 전체 통계/운영

9) backend/app/utils/
errors.py: 커스텀 예외/에러코드
pagination.py: 페이징 유틸
time_utils.py: 분기 계산/전분기 처리 등

10) backend/app/tests/
최소 테스트(인증/적재/예측/점수)

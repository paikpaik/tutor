---
name: tutor-setup
description: "문서/코드베이스를 Obsidian StudyVault로 변환합니다. Document Mode(PDF·텍스트·웹)와 Codebase Mode(소스코드) 두 가지를 자동 감지하여 처리합니다."
---

# Tutor Setup — 지식을 Obsidian StudyVault로

## CWD 경계 규칙 (모든 모드 공통)

> **CWD 외부 파일에 절대 접근하지 않는다.**
> 소스 스캔, 읽기, 볼트 출력 모두 CWD 및 하위 디렉토리 내에서만 진행한다.
> 외부 경로를 제공하는 경우, 파일을 CWD로 복사해달라고 요청한다.

## 모드 감지

실행 시 자동으로 모드를 감지한다:

1. **CWD에서 프로젝트 마커 확인**:
   - `package.json`, `pom.xml`, `build.gradle`, `Cargo.toml`, `go.mod`, `Makefile`,
   `*.sln`, `pyproject.toml`, `setup.py`, `Gemfile`
2. **마커가 있으면** → **코드베이스 모드**
3. **마커가 없으면** → **문서 모드**
4. **판단 불가 시**: `.git/`만 있고 소스 코드 파일(`*.ts`, `*.py`, `*.java`, `*.go`, `*.rs` 등)이 없으면 문서 모드로 기본 설정.
5. 감지된 모드를 사용자에게 알리고 확인 또는 변경 요청.

---

## 문서 모드

> 지식 소스(PDF, 텍스트, 웹, epub)를 학습 노트로 변환한다.
> 양식: [templates.md](references/templates.md)

### Phase D1: 소스 탐색 및 추출

1. **CWD 자동 스캔**: `**/*.pdf`, `**/*.txt`, `**/*.md`, `**/*.html`, `**/*.epub` 검색 (`node_modules/`, `.git/`, `dist/`, `build/`, `StudyVault/` 제외). 결과를 사용자에게 제시하고 확인.
2. **텍스트 추출 (필수 도구)**:
   - **PDF → `pdftotext` CLI만 사용** (Bash 도구로 실행). PDF 파일에 Read 도구를 직접 사용하면 이미지로 렌더링되어 토큰을 10-50배 낭비한다. 먼저 `.txt`로 변환 후 Read로 읽는다.
   ```bash
   pdftotext "source.pdf" "/tmp/source.txt"
   ```
   - `pdftotext`가 없으면 먼저 설치: `brew install poppler` (macOS) 또는 `apt-get install poppler-utils` (Linux).
   - URL → WebFetch
   - 그 외 형식(`.md`, `.txt`, `.html`) → Read로 직접 읽기.
3. **추출된 `.txt` 파일 읽기** — 범위, 구조, 깊이 파악. 원본 PDF가 아닌 변환된 텍스트만 사용한다.
4. **소스 내용 매핑 (다중 파일 소스에서 필수)**:
   - 모든 소스 파일의 **표지 + 목차 + 중간/끝에서 3페이지 이상** 읽기
   - **파일명으로 내용을 추정하지 않는다** — 파일 번호와 챕터 번호는 다를 수 있다
   - 검증된 매핑 작성: `{ 소스파일 → 실제 주제 → 페이지 범위 }`
   - 비학술 파일 및 누락 소스 표시
   - 진행 전 매핑을 사용자에게 제시하고 검증

### Phase D2: 내용 분석

1. 주제 계층 파악 — 섹션, 챕터, 도메인 구분.
2. 개념 내용과 연습 문제 분리.
3. 주제 간 의존 관계 매핑.
4. 핵심 패턴 파악 — 비교, 의사결정 트리, 공식.
5. **전체 주제 체크리스트 작성 (필수)** — 모든 주제/하위 주제 나열. 이후 모든 단계의 기준이 된다.

> **Equal Depth Rule**: 짧게 언급된 하위 주제라도 반드시 교과서 수준의 지식으로 보완한 전용 노트를 작성한다.

6. **분류 완전성**: 소스에서 항목을 열거할 때("X의 3가지 유형"), 모든 항목에 전용 노트를 작성한다. "types of", "N가지", "categories", "there are N" 등을 스캔한다.
7. **소스-노트 교차 검증 (필수)**: 각 주제를 다루는 소스 파일과 페이지 범위를 기록한다. 추적 불가 주제는 "원문 미보유"로 표시한다.

### Phase D3: 태그 표준

노트 생성 전에 태그 어휘를 정의한다:
- **형식**: 영문, 소문자, kebab-case (예: `#data-hazard`)
- **계층**: 최상위 → 도메인 → 세부 → 기법 → 노트 유형
- **레지스트리**: 등록된 태그만 허용. 세부 태그는 상위 도메인 태그를 함께 붙인다.

### Phase D4: 볼트 구조

[templates.md](references/templates.md)에 따라 번호 붙은 폴더로 `StudyVault/`를 생성한다. 파일당 관련 개념 3-5개씩 묶는다.

### Phase D5: 대시보드 생성

[templates.md](references/templates.md)를 참고하여 `00-Dashboard/`에 MOC, Quick Reference, Exam Traps 생성.

- **MOC**: 주제 맵 + 연습 노트 + 학습 도구 + 태그 인덱스(규칙 포함) + 취약 영역(링크 포함) + 비핵심 주제 정책
- **Quick Reference**: 모든 헤딩에 `→ [[개념 노트]]` 링크 포함; 모든 핵심 공식
- **Exam Traps**: 주제별 함정 포인트를 fold callout으로, 개념 노트와 링크

### Phase D6: 개념 노트

[templates.md](references/templates.md) 기준. 핵심 규칙:
- YAML 프론트매터: `source_pdf`, `part`, `keywords` (필수)
- **source_pdf는 반드시 Phase D1에서 검증된 매핑과 일치해야 함** — 파일명으로 추정 금지
- 원문이 없을 경우: `source_pdf: 원문 미보유`
- `[[wiki-links]]`, callout(`[!tip]`, `[!important]`, `[!warning]`), 비교표 우선 (산문 지양)
- 프로세스/흐름/시퀀스에 ASCII 다이어그램
- **예외 명시 원칙**: 일반적 서술에는 반드시 엣지 케이스를 기록한다

### Phase D7: 연습 문제

[templates.md](references/templates.md) 기준. 핵심 규칙:
- 모든 주제 폴더에 연습 파일 필수 (8문제 이상)
- **능동적 회상**: 정답은 `> [!answer]- 정답 보기` fold callout 사용
- 패턴은 `> [!hint]-` / `> [!summary]-` fold callout 사용
- **문제 유형 다양성**: 파일당 암기 ≥60%, 적용 ≥20%, 분석 ≥2개
- `## 관련 개념`에 `[[wiki-links]]` 포함

### Phase D8: 상호 링크

1. 모든 개념 노트에 `## 관련 노트`
2. MOC가 모든 개념 노트 및 연습 파일에 링크
3. 개념 노트 ↔ 연습 문제 상호 링크; 형제 노트끼리 상호 참조
4. Quick Reference 섹션 → `[[개념 노트]]` 링크
5. 취약 영역 → 관련 노트 + Exam Traps; Exam Traps → 개념 노트

### Phase D9: 자가검토 (필수)

[quality-checklist.md](references/quality-checklist.md)의 **문서 모드** 섹션을 기준으로 검토한다. 모든 항목을 통과할 때까지 수정하고 재검토한다.

---

## 코드베이스 모드

> 소스 코드 프로젝트에서 신규 개발자 온보딩용 StudyVault를 생성한다.
> 전체 워크플로: [codebase-workflow.md](references/codebase-workflow.md)
> 양식: [codebase-templates.md](references/codebase-templates.md)

### 단계 요약

| Phase | 이름 | 핵심 작업 |
|-------|------|-----------|
| C1 | 프로젝트 탐색 | 파일 스캔, 기술 스택 감지, 진입점 읽기, 디렉토리 레이아웃 매핑 |
| C2 | 아키텍처 분석 | 패턴 식별, 요청 흐름 추적, 모듈 경계 및 데이터 흐름 매핑 |
| C3 | 태그 표준 | `#arch-*`, `#module-*`, `#pattern-*`, `#api-*` 태그 레지스트리 정의 |
| C4 | 볼트 구조 | Dashboard, Architecture, 모듈별, DevOps, Exercises 폴더로 `StudyVault/` 생성 |
| C5 | 대시보드 | MOC (모듈 맵 + API 표면 + Getting Started + 온보딩 경로) + Quick Reference |
| C6 | 모듈 노트 | 모듈별 노트: Purpose, Key Files, Public Interface, Internal Flow, Dependencies |
| C7 | 온보딩 연습 | 코드 읽기, 설정, 디버깅, 확장 연습 (주요 모듈당 5개 이상) |
| C8 | 상호 링크 | 모듈 간 연결, 아키텍처 ↔ 구현체, 연습 ↔ 모듈 |
| C9 | 자가검토 | [quality-checklist.md](references/quality-checklist.md) **코드베이스 모드** 섹션 기준 검토 |

상세 단계별 지침은 [codebase-workflow.md](references/codebase-workflow.md) 참조.

---

## 언어

- 소스 자료의 언어에 맞춰 작성한다 (한국어 소스 → 한국어 노트 등)
- **태그/키워드**: 반드시 영문 사용

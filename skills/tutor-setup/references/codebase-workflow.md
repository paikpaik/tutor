# 코드베이스 모드 — 온보딩 볼트 워크플로

> 모든 단계는 CWD 내에서만 진행한다. 외부 경로 접근 금지.

---

## Phase C1: 프로젝트 탐색

1. **프로젝트 구조 스캔**: `find . -type f | head -100` 실행하여 디렉토리 구조 파악.
2. **기술 스택 식별**: `package.json`, `Cargo.toml`, `go.mod`, `pom.xml` 등 확인.
3. **진입점 읽기**: `main.ts`, `index.js`, `main.go`, `App.java` 등.
4. **디렉토리 레이아웃 매핑**: `src/`, `lib/`, `tests/`, `docs/`, `config/` 패턴 파악.
5. **사용자에게 요약 제시**: 감지된 스택, 진입점, 주요 모듈.

## Phase C2: 아키텍처 분석

1. **아키텍처 패턴 식별**: Layered, MVC, Microservice, Event-driven 등.
2. **요청/이벤트 흐름 추적**: 진입점부터 각 레이어를 거쳐 출력까지.
3. **모듈 경계 매핑**: 각 모듈이 소유하는 것, 외부에 노출하는 것.
4. **데이터 흐름 파악**: 모듈을 통과하면서 데이터가 어떻게 변환되는지.
5. **핵심 디자인 패턴 기록**: Repository, Factory, Observer 등.

## Phase C3: 태그 표준

노트 생성 전에 태그 어휘를 정의한다:
- `#arch-<패턴>` — 아키텍처 패턴 (예: `#arch-layered`, `#arch-mvc`)
- `#module-<이름>` — 모듈별 태그
- `#pattern-<이름>` — 디자인 패턴
- `#api-<표면>` — API 관련 태그
- **형식**: 영문, 소문자, kebab-case만 허용

## Phase C4: 볼트 구조

```
StudyVault/
├── 00-Dashboard/
│   ├── MOC.md
│   └── Quick-Reference.md
├── 01-Architecture/
│   ├── System-Overview.md
│   └── Request-Flow.md
├── 02-<모듈-A>/
│   └── <모듈-A>.md
├── 03-<모듈-B>/
│   └── <모듈-B>.md
├── NN-DevOps/
│   └── Setup-Deploy.md
└── NN+1-Exercises/
    ├── Code-Reading.md
    ├── Configuration.md
    ├── Debugging.md
    └── Extension.md
```

## Phase C5: 대시보드

`00-Dashboard/MOC.md` 생성 내용:
- **아키텍처 개요**: 시스템 다이어그램 (ASCII), 기술 스택 표
- **모듈 맵**: 모든 모듈과 목적, wiki-link
- **API 표면**: 주요 엔드포인트 또는 인터페이스
- **Getting Started**: 프로젝트 실행 명령어 (복붙 가능)
- **온보딩 경로**: 권장 읽기 순서

`00-Dashboard/Quick-Reference.md` 생성 내용:
- 주요 명령어 (빌드, 테스트, 실행, 배포)
- 환경 변수
- 중요 파일 위치
- 자주 쓰는 디버깅 절차

## Phase C6: 모듈 노트

주요 모듈마다 [codebase-templates.md](codebase-templates.md)의 양식으로 노트를 작성한다.

핵심 규칙:
- YAML 프론트매터: `module`, `path`, `tech_stack`, `keywords` (필수)
- 섹션: Purpose, Key Files, Public Interface, Internal Flow, Dependencies, Config, Testing
- 내부 흐름에 ASCII 다이어그램 사용
- 의존 모듈에 wiki-link

## Phase C7: 온보딩 연습 문제

`NN+1-Exercises/`에 연습 문제를 작성한다:
- **코드 읽기**: "X가 호출될 때 어떤 일이 일어나는지 추적하라"
- **설정**: "Y 기능을 위한 환경을 구성하라"
- **디버깅**: "의도적으로 심어둔 버그를 찾아 수정하라"
- **확장**: "기존 패턴을 따라 Z 기능을 추가하라"

규칙:
- 주요 모듈별 최소 5개의 연습 문제
- 모든 정답은 `> [!answer]- 정답 보기` fold callout 사용
- 연습 문제가 다루는 모듈 노트를 참조할 것

## Phase C8: 상호 링크

1. MOC → 모든 모듈 노트 및 아키텍처 문서
2. 아키텍처 노트 → 모듈 구현체
3. 모듈 노트 → 의존 모듈 (양방향)
4. 연습 문제 → 해당 모듈 노트
5. Quick Reference → 관련 모듈 노트

## Phase C9: 자가검토

완료 보고 전에 [quality-checklist.md](quality-checklist.md)의 **코드베이스 모드** 섹션을 기준으로 검토하고 모든 문제를 수정한다.

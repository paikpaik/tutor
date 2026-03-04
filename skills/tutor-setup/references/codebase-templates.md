# 코드베이스 모드 — 노트 양식

## 볼트 폴더 구조

```
StudyVault/
├── 00-Dashboard/
│   ├── MOC.md
│   └── Quick-Reference.md
├── 01-Architecture/
│   ├── System-Overview.md
│   └── Request-Flow.md
├── 02-<모듈>/
│   └── <모듈>.md
├── NN-DevOps/
│   └── Setup-Deploy.md
└── NN+1-Exercises/
    ├── Code-Reading.md
    ├── Configuration.md
    ├── Debugging.md
    └── Extension.md
```

---

## 양식: 대시보드 MOC

```markdown
---
tags: [dashboard, moc, codebase]
project: <프로젝트명>
stack: [<기술1>, <기술2>]
---

# 🗺️ <프로젝트명> — 개발자 온보딩 맵

## 아키텍처 개요
```
<ASCII 시스템 다이어그램>
```

| 레이어 | 기술 | 역할 |
|--------|------|------|
| <레이어> | <기술> | <역할> |

## 모듈 맵
| 모듈 | 경로 | 역할 |
|------|------|------|
| [[02-모듈-A/모듈-A]] | `src/module-a/` | <역할> |
| [[03-모듈-B/모듈-B]] | `src/module-b/` | <역할> |

## API 표면
| 엔드포인트/인터페이스 | 모듈 | 설명 |
|----------------------|------|------|
| `GET /api/foo` | [[02-모듈-A/모듈-A]] | <설명> |

## Getting Started
```bash
# 클론 및 설치
git clone <repo>
cd <project>
<설치 명령어>

# 실행
<실행 명령어>

# 테스트
<테스트 명령어>
```

## 온보딩 경로
1. [[01-Architecture/System-Overview]] 읽기
2. [[02-모듈-A/모듈-A]] 읽기
3. [[NN+1-Exercises/Code-Reading]] 연습 1-2번 풀기
4. [[03-모듈-B/모듈-B]] 읽기
5. [[NN+1-Exercises/Debugging]] 연습 1번 풀기
```

---

## 양식: 모듈 노트

```markdown
---
tags: [module-<이름>, arch-<패턴>]
module: <모듈명>
path: src/<모듈-디렉토리>/
tech_stack: [<기술1>, <기술2>]
keywords: [키워드1, 키워드2]
---

# <모듈명>

## 목적
<이 모듈이 하는 일과 존재 이유를 1-2문장으로>

## 핵심 파일
| 파일 | 역할 |
|------|------|
| `src/<모듈>/index.ts` | 진입점, public API 노출 |
| `src/<모듈>/service.ts` | 핵심 비즈니스 로직 |
| `src/<모듈>/types.ts` | 타입 정의 |

## Public Interface
```typescript
// 주요 export / API 표면
export function doSomething(input: InputType): OutputType
export class MainClass { ... }
```

## 내부 흐름
```
요청 → 검증 → 서비스 → 저장소 → DB
          ↓
      에러 핸들러
```

## 의존성
| 모듈 | 이유 |
|------|------|
| [[03-모듈-B/모듈-B]] | X 처리에 사용 |
| [[01-Architecture/System-Overview]] | Y 레이어의 일부 |

## 설정
| 변수 | 기본값 | 목적 |
|------|--------|------|
| `MODULE_TIMEOUT` | `5000` | 요청 타임아웃 (ms) |

## 테스트
```bash
# 이 모듈 테스트 실행
<테스트 명령어>
```

> [!tip] 핵심 인사이트
> <이 모듈에서 가장 중요하게 이해해야 할 것>

## 관련 노트
- [[01-Architecture/System-Overview]]
- [[03-모듈-B/모듈-B]]
```

---

## 양식: 연습 문제

```markdown
---
tags: [exercise, module-<이름>]
covers: [[02-모듈-A/모듈-A]]
---

# 연습문제: <주제>

## 연습 1. 코드 읽기 — <제목>

**과제**: `<함수>`가 입력값 `<값>`으로 호출될 때 어떤 일이 일어나는지 추적하라.

`src/<파일>.ts:42`에서 시작해 실행 경로를 따라가라.

> [!answer]- 정답 보기
> 1. `<함수>`가 42번 줄에서 입력값 검증
> 2. `<서비스>.process()`를 호출하면...
> 3. `<타입>`을 반환하는 이유는...

---

## 연습 2. 설정 — <제목>

**과제**: `<기능>`을 활성화하도록 모듈을 설정하라.

어떤 환경 변수를 어떤 값으로 설정해야 하는가?

> [!answer]- 정답 보기
> `.env`에 `<ENV_VAR>=<값>` 설정.
> X가 활성화되는 이유는...

---

## 연습 3. 디버깅 — <제목>

**과제**: 다음 코드에 버그가 있다. 찾아서 수정하라.

```typescript
<버그가 있는 코드>
```

> [!answer]- 정답 보기
> **버그**: N번 줄 — `<버그 설명>`
> **수정**: `<잘못된 코드>`를 `<올바른 코드>`로 변경
> **이유**: `<설명>`

---

## 연습 4. 확장 — <제목>

**과제**: `<모듈>`의 기존 패턴을 따라 `<새 기능>`을 추가하라.

어떤 파일을 수정하고 무엇을 추가하겠는가?

> [!answer]- 정답 보기
> 1. `src/<파일>.ts` 수정 — `<무엇>` 추가
> 2. `tests/<파일>.test.ts`에 테스트 추가
> 참고 패턴: `<기존 함수>`

<!-- 주요 모듈별 최소 5개의 연습 문제 -->
```

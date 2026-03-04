#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
SKILLS=("tutor-setup" "tutor")

echo "tutor-skills 설치 중..."
echo ""

for skill in "${SKILLS[@]}"; do
  TARGET="$SKILLS_DIR/$skill"

  if [ -d "$TARGET" ]; then
    printf "  '%s' 가 이미 존재합니다. 덮어쓸까요? (y/N): " "$skill"
    read -r answer
    if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
      echo "  → 건너뜀: $skill"
      continue
    fi
    rm -rf "$TARGET"
  fi

  mkdir -p "$TARGET/references"
  cp "$SCRIPT_DIR/skills/$skill/SKILL.md" "$TARGET/SKILL.md"
  cp "$SCRIPT_DIR/skills/$skill/references/"* "$TARGET/references/" 2>/dev/null || true
  echo "  → 설치 완료: $skill"
done

echo ""
echo "설치 완료!"
echo "  /tutor-setup  — 문서 또는 코드베이스에서 StudyVault 생성"
echo "  /tutor        — 대화형 퀴즈 시작"

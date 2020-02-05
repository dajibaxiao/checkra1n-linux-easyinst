#!/bin/bash
if [[ "$EUID" -ne 0 ]]; then
	echo "권한이 부족합니다. 권한 상승을 위해 비밀번호를 입력해 주세요."
	echo "비밀번호는 외부로 전송되지 않습니다."
	sudo echo "정상적으로 권한이 상승되었습니다."
else
	echo "Superuser 권한이 부여되어있습니다."
fi
echo "[1/6] 명령 아웃풋을 지정중입니다..."
OUTPUTD="$HOME/CheckRa1nEasyInstLog.txt"
touch "$OUTPUTD"
echo "[2/6] APT 저장소에 CheckRa1n 의 저장소를 추가중입니다..."
sudo echo "deb https://assets.checkra.in/debian /" >> /etc/apt/sources.list
echo "[3/6] GPG 키를 받아오는중입니다..."
sudo apt-key adv --fetch-keys https://assets.checkra.in/debian/archive.key >> "$OUTPUTD"
echo "[4/6] APT 저장소 정보들을 업데이트하는 중입니다..."
sudo apt update >> "$OUTPUTD"
echo "[5/6] CheckRa1n 과 의존 패키지를 내려받는 중입니다..."
sudo apt-get install checkra1n -y >> "$OUTPUTD"
echo "[6/6] 바로가기를 바탕화면에 생성중입니다..."
DESKT=""
if [[ -d "$HOME/바탕화면" ]]; then
	DESKT="$HOME/바탕화면"
else
	DESKT="$HOME/Desktop"
fi
echo "sudo checkra1n" > "$DESKT/CheckRa1n.sh"
chmod +x "$DESKT/CheckRa1n.sh"
echo "설치 과정이 완료되었습니다. 지금 바로 CheckRa1n을 실행하시겠습니까? (y/n)"
read booleand
if [[ "$booleand" == "Y" ]] || [[ "$booleand" == "y" ]]; then
	echo "CheckRa1n 을 실행합니다."
	clear
	sudo checkra1n
	exit $?
else
	echo "설치 도우미를 종료합니다."
	exit 0
fi
SELECT * FROM TAB;

DESC TEAM;

DESC STADIM;

DESC SCHEDULE;

DESC PLAYER;

SELECT *
FROM PLAYER
WHERE BACK_NO LIKE '20';

-- SQL_TEST_001
-- ��ü �౸�� ���. �̸� ��������

SELECT 
    TEAM_NAME "��ü �౸�� ���"
FROM TEAM
ORDER BY TEAM_NAME;

-- SQL_TEST_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- nvl2()���


SELECT DISTINCT NVL2(POSITION,POSITION,'����') ������
FROM PLAYER;

-- SQL_TEST_004
-- ������(ID: K02)��Ű��

SELECT 
    PLAYER_NAME �̸�
FROM PLAYER
WHERE TEAM_ID LIKE 'K02' AND POSITION LIKE 'GK';
    
    
-- SQL_TEST_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ���� ����

SELECT POSITION ������,PLAYER_NAME �̸�
FROM PLAYER
WHERE TEAM_ID LIKE 'K02' AND HEIGHT >= 170 AND PLAYER_NAME LIKE '��%';
    

-- SQL_TEST_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������

SELECT CONCAT(PLAYER_NAME,'����')�̸�,
              TO_CHAR (NVL2(HEIGHT,HEIGHT,0) || 'CM')Ű,
              TO_CHAR (NVL2(WEIGHT,WEIGHT,0) || 'KG')������
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY HEIGHT DESC;
    


-- SQL_TEST_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������

SELECT CONCAT(PLAYER_NAME,'����')�̸�,
              TO_CHAR (NVL2(HEIGHT,HEIGHT,0) || 'CM')Ű,
              TO_CHAR (NVL2(WEIGHT,WEIGHT,0) || 'KG')������,
              ROUND(WEIGHT /(HEIGHT*HEIGHT)*10000,2) BMI������
FROM PLAYER
WHERE TEAM_ID LIKE 'K02'
ORDER BY WEIGHT DESC;
    

SELECT CONCAT(PLAYER_NAME,'����')�̸�,
              TO_CHAR (NVL2(HEIGHT,HEIGHT,0) || 'CM')Ű,
              TO_CHAR (NVL2(WEIGHT,WEIGHT,0) || 'KG')������,
              ROUND(WEIGHT /(HEIGHT*HEIGHT)*10000,2) BMI������
FROM (SELECT PLAYER_NAME,HEIGHT,WEIGHT
      FROM PLAYER
      WHERE TEAM_ID LIKE 'K02')
ORDER BY WEIGHT DESC;

SELECT PLAYER_NAME,HEIGHT,WEIGHT
      FROM PLAYER
      WHERE TEAM_ID LIKE 'K02';

-- SQL_TEST_008
-- ������(ID: K02) �� ������(ID: K10)������ �� 
--  �������� GK ��  ����
-- ����, ����� ��������

SELECT T.TEAM_NAME,
       P.POSITION,
       P.PLAYER_NAME
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.TEAM_ID IN ('K02','K10') AND POSITION LIKE 'GK'
ORDER BY T.TEAM_NAME, P.PLAYER_NAME DESC;

-- SQL_TEST_009
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������

SELECT TO_CHAR(HEIGHT || 'CM') Ű,
       T.TEAM_NAME ����,
       P.PLAYER_NAME �̸�
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.TEAM_ID IN ('K02','K10') AND HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT,T.TEAM_NAME,P.PLAYER_NAME;




-- SOCCER_SQL_010
-- ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������
 
SELECT T.TEAM_NAME, P.PLAYER_NAME
FROM (SELECT PLAYER_NAME,TEAM_ID FROM PLAYER WHERE POSITION IS NULL) P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY T.TEAM_NAME,P.PLAYER_NAME;


-- SOCCER_SQL_011
-- ���� ��Ÿ����� �����Ͽ�
-- ���̸�, ��Ÿ��� �̸� ���
 
SELECT TEAM_NAME ����,STADIUM_NAME ��Ÿ���
FROM TEAM T
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID
ORDER BY TEAM_NAME;


-- SOCCER_SQL_012
-- ���� ��Ÿ���, �������� �����Ͽ�
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- �������̺� join �� ã�Ƽ� �ذ��Ͻÿ�



SELECT T.TEAM_NAME ���̸�,
       S.STADIUM_NAME ��Ÿ���, 
       K.AWAYTEAM_ID �������,
       K.SCHE_DATE �����ٳ�¥
FROM STADIUM S
    JOIN SCHEDULE K
        ON S.STADIUM_ID LIKE K.STADIUM_ID
    JOIN TEAM T
        ON S.STADIUM_ID LIKE T.STADIUM_ID
WHERE K.SCHE_DATE LIKE 20120317
ORDER BY TEAM_NAME;

-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�

SELECT PLAYER_NAME ������,
       POSITION ������,
       REGION_NAME || ' ' ||TEAM_NAME ����,
       STADIUM_NAME ��Ÿ���,
       SCHE_DATE �����ٳ�¥
FROM TEAM T
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
WHERE C.SCHE_DATE LIKE 20120317 AND P.POSITION LIKE 'GK' AND TEAM_NAME LIKE '��ƿ����'
ORDER BY PLAYER_NAME;


-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�

SELECT * FROM SCHEDULE;

SELECT S.STADIUM_NAME ��Ÿ���,
       C.SCHE_DATE ��⳯¥,
       (SELECT REGION_NAME || ' ' || TEAM_NAME FROM TEAM WHERE TEAM_ID LIKE C.HOMETEAM_ID) Ȩ��,
       (SELECT REGION_NAME || ' ' || TEAM_NAME FROM TEAM WHERE TEAM_ID LIKE C.AWAYTEAM_ID) ������,
       C.HOME_SCORE "Ȩ�� ����",
       C.AWAY_SCORE "������ ����"
FROM STADIUM S
    JOIN (SELECT SCHE_DATE,STADIUM_ID,HOMETEAM_ID,AWAYTEAM_ID,HOME_SCORE,AWAY_SCORE FROM SCHEDULE WHERE (HOME_SCORE - AWAY_SCORE) >= 3) C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
    JOIN TEAM T
        ON S.STADIUM_ID LIKE T.STADIUM_ID
ORDER BY HOME_SCORE DESC;


-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20
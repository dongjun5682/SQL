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
       (SELECT T.TEAM_NAME
        FROM TEAM T
        WHERE T.TEAM_ID LIKE K.AWAYTEAM_ID)�������,
       K.SCHE_DATE �����ٳ�¥
FROM STADIUM S
    JOIN (SELECT HOMETEAM_ID,C.STADIUM_ID,AWAYTEAM_ID,SCHE_DATE 
          FROM SCHEDULE C 
          WHERE C.SCHE_DATE LIKE '20120317') K
        ON S.STADIUM_ID LIKE K.STADIUM_ID
    JOIN TEAM T
        ON S.STADIUM_ID LIKE T.STADIUM_ID
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


SELECT PLAYER_NAME ������,
       POSITION ������,
       REGION_NAME || ' ' ||TEAM_NAME ����,
       STADIUM_NAME ��Ÿ���,
       SCHE_DATE �����ٳ�¥
FROM (SELECT TEAM_ID,STADIUM_ID,REGION_NAME,TEAM_NAME FROM TEAM T WHERE T.TEAM_NAME LIKE '��ƿ����') T
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
WHERE C.SCHE_DATE LIKE 20120317 AND P.POSITION LIKE 'GK'
ORDER BY PLAYER_NAME;




-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�

SELECT * FROM SCHEDULE;

SELECT S.STADIUM_NAME ��Ÿ���,
       C.SCHE_DATE ��⳯¥,
       (SELECT REGION_NAME || ' ' || TEAM_NAME 
        FROM TEAM 
        WHERE TEAM_ID LIKE C.HOMETEAM_ID) Ȩ��,
       (SELECT REGION_NAME || ' ' || TEAM_NAME 
        FROM TEAM 
        WHERE TEAM_ID LIKE C.AWAYTEAM_ID) ������,
       C.HOME_SCORE "Ȩ�� ����",
       C.AWAY_SCORE "������ ����"
FROM STADIUM S
    JOIN (SELECT SCHE_DATE,STADIUM_ID,HOMETEAM_ID,AWAYTEAM_ID,HOME_SCORE,AWAY_SCORE 
          FROM SCHEDULE 
          WHERE (HOME_SCORE - AWAY_SCORE) >= 3) C
        ON S.STADIUM_ID LIKE C.STADIUM_ID
ORDER BY HOME_SCORE DESC;

SELECT SCHE_DATE,STADIUM_ID,HOMETEAM_ID,AWAYTEAM_ID,HOME_SCORE,AWAY_SCORE FROM SCHEDULE WHERE (HOME_SCORE - AWAY_SCORE) >= 3 ;

-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20

SELECT STADIUM_NAME,
       S.STADIUM_ID,
       SEAT_COUNT,
       HOMETEAM_ID,
       T.E_TEAM_NAME
FROM STADIUM S
    LEFT JOIN (SELECT T.E_TEAM_NAME,T.STADIUM_ID FROM TEAM T) T
        ON S.STADIUM_ID LIKE T.STADIUM_ID;


SELECT STADIUM_NAME,
       S.STADIUM_ID,
       SEAT_COUNT,
       HOMETEAM_ID,
       (SELECT T.E_TEAM_NAME 
        FROM TEAM T 
        WHERE T.STADIUM_ID LIKE S.STADIUM_ID)E_TEAM_NAME
FROM STADIUM S;


SELECT T.E_TEAM_NAME 
        FROM TEAM T 
        WHERE T.STADIUM_ID LIKE S.STADIUM_ID;

-- SOCCER_SQL_016
-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����

SELECT P.TEAM_ID ��ID, 
    T.TEAM_NAME ����, 
    ROUND(AVG(P.HEIGHT),2) ���Ű
FROM TEAM T
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY P.TEAM_ID, T.TEAM_NAME
HAVING AVG(P.HEIGHT) < (SELECT AVG(P.HEIGHT)
                        FROM TEAM T
                            JOIN PLAYER P
                                ON T.TEAM_ID LIKE P.TEAM_ID
                        WHERE T.TEAM_NAME LIKE '������Ƽ��')
ORDER BY ���Ű;

-- SOCCER_SQL_017
-- �������� MF �� ��������  �Ҽ����� �� ������, ��ѹ� ���

SELECT (SELECT TEAM_NAME FROM TEAM WHERE TEAM_ID LIKE P.TEAM_ID) ����,
       PLAYER_NAME ������,
       BACK_NO ��ѹ�
FROM (SELECT PLAYER_NAME,BACK_NO,TEAM_ID,POSITION FROM PLAYER) P
WHERE POSITION LIKE 'MF'
ORDER BY PLAYER_NAME;


-- SOCCER_SQL_018
-- ���� Űū ���� 5 ����, ����Ŭ, �� Ű ���� ������ ����

SELECT P.PLAYER_NAME ������,
       P.BACK_NO ��ѹ�,
       P.POSITION ������,
       P.HEIGHT Ű
FROM (SELECT PLAYER_NAME,
             BACK_NO,
             POSITION,
             HEIGHT 
      FROM PLAYER 
      WHERE HEIGHT IS NOT NULL
      ORDER BY HEIGHT DESC)P
WHERE ROWNUM BETWEEN 1 AND 5;


-- SOCCER_SQL_019
-- ���� �ڽ��� ���� ���� ���Ű���� ���� ���� ���� ���


SELECT  TEAM_NAME,
        PLAYER_NAME, 
        POSITION, 
        BACK_NO,
        HEIGHT
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.HEIGHT < (SELECT ROUND(AVG(HEIGHT),2) FROM PLAYER P2 WHERE P2.TEAM_ID LIKE P.TEAM_ID)
ORDER BY P.PLAYER_NAME;


-- SOCCER_SQL_020
-- 2012�� 5�� �Ѵް� ��Ⱑ �ִ� ����� ��ȸ
-- EXISTS ������ �׻� ���������� ����Ѵ�.
-- ���� �ƹ��� ������ �����ϴ� ���� ���� ���̶�
-- ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�.

SELECT STADIUM_ID ID,
       STADIUM_NAME ������
FROM STADIUM S
WHERE EXISTS (SELECT 1
              FROM SCHEDULE C 
              WHERE C.STADIUM_ID = S.STADIUM_ID AND SCHE_DATE BETWEEN '20120501' AND '20120531');


-- SOCCER_SQL_021
-- ���� ���� �Ҽ����� ������� ���

SELECT PLAYER_NAME ������,
       POSITION ������,
       BACK_NO ��ѹ�
FROM PLAYER P
WHERE TEAM_ID LIKE(SELECT TEAM_ID 
                   FROM PLAYER 
                   WHERE PLAYER_NAME LIKE '����' )
ORDER BY PLAYER_NAME;


-- SOCCER_SQL_022
-- NULL ó���� �־�
-- SUM(NVL(SAL,0)) �� ��������
-- NVL(SUM(SAL),0) ���� �ؾ� �ڿ����� �پ���
 
-- ���� �����Ǻ� �ο����� ���� ��ü �ο��� ���
 
-- Oracle, Simple Case Expr 


 SELECT TEAM_ID,
              NVL(SUM(CASE WHEN POSITION = 'FW' THEN 1 END), 0) FW,
              NVL(SUM(CASE WHEN POSITION = 'MF' THEN 1 END), 0) MF,
              NVL(SUM(CASE WHEN POSITION = 'DF' THEN 1 END), 0) DF,
              NVL(SUM(CASE WHEN POSITION = 'GK' THEN 1 END), 0) GK,
              COUNT(*) SUM
 FROM PLAYER P
 GROUP BY TEAM_ID;
 
DESC TEAM;
 
 -- SOCCER_SQL_023
-- GROUP BY �� ���� ��ü �������� �����Ǻ� ��� Ű �� ��ü ��� Ű ���

SELECT ROUND(AVG(CASE WHEN POSITION = 'MF' THEN HEIGHT END),2) �̵��ʴ�,
       ROUND(AVG(CASE WHEN POSITION = 'FW' THEN HEIGHT END),2) ������,
       ROUND(AVG(CASE WHEN POSITION = 'DF' THEN HEIGHT END),2) �����,
       ROUND(AVG(CASE WHEN POSITION = 'GK' THEN HEIGHT END),2) ��Ű��,
       ROUND(AVG(HEIGHT),2)���Ű
FROM PLAYER;

-- SOCCER_SQL_024 
-- �Ҽ����� Ű�� ���� ���� ������� ����

SELECT P.TEAM_ID,
       TEAM_NAME,
       PLAYER_NAME,
       POSITION,
       BACK_NO,
       HEIGHT
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY HEIGHT;
        
        
        
        
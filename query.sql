CREATE TABLE measurement (   --создание таблицы с использованием партиционирования
    city_id         int not null,
    logdate         date not null,
    peaktemp        int,
    unitsales       int
) PARTITION BY RANGE (logdate);

CREATE TABLE measurement_y2006m02 PARTITION OF measurement --создание партиций по датам
    FOR VALUES FROM ('2006-02-01') TO ('2006-03-01');

CREATE TABLE measurement_y2006m03 PARTITION OF measurement
    FOR VALUES FROM ('2006-03-01') TO ('2006-04-01');

CREATE TABLE measurement_y2006m04 PARTITION OF measurement
    FOR VALUES FROM ('2006-04-01') TO ('2006-05-01');

CREATE INDEX ON measurement_y2006m02 (logdate); --создание индексов
CREATE INDEX ON measurement_y2006m03 (logdate);
CREATE INDEX ON measurement_y2006m04 (logdate);

INSERT INTO measurement VALUES (2, '2006-04-09',2,7) --вставка данных
INSERT INTO measurement VALUES (3, '2006-02-27',1,4)
INSERT INTO measurement VALUES (4, '2006-02-24',3,11)
INSERT INTO measurement VALUES (5, '2006-03-10',3,2)
INSERT INTO measurement VALUES (6, '2006-04-14',3,5)
INSERT INTO measurement VALUES (7, '2006-02-10',1,12)

select * from measurement;

select * from measurement_y2006m02;

DROP TABLE measurement_y2006m02;--удаление февральских данных

ALTER TABLE measurement DETACH PARTITION measurement_y2006m02;-- отделение мартовских данных от общих
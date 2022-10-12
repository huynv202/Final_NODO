--A

--Create model

create table loai_sach_huy
(
    id number primary key,
    code varchar2(30),
    name varchar2(100)
);
create table sach_huy(id number primary key,
                  loai_sach_id number,
                  code varchar2(30),
                  name varchar2(100),
                  status varchar2(1)
);

create table nhan_vien_huy
(
    id number primary key,
    phong_ban_id number,
    code varchar2(30),
    name varchar2(100),
    status varchar2(1)
);

create table phong_ban_huy
(
    id number primary key,
    code varchar2(30),
    name varchar2(100),
    status varchar2(1)
);
create table muon_sach_huy
(
    id number primary key,
    sach_id number,
    nhan_vien_id number,
    ngay_muon date,
    status varchar2(1),
    ngay_tra date
);

select * from loai_sach_huy;

ALTER TABLE sach_huy
    ADD FOREIGN KEY (loai_sach_id) REFERENCES loai_sach_huy(id);

ALTER TABLE muon_sach_huy
    ADD FOREIGN KEY (sach_id) REFERENCES sach_huy(id);

ALTER TABLE muon_sach_huy
    ADD FOREIGN KEY (nhan_vien_id) REFERENCES nhan_vien_huy(id);

ALTER TABLE nhan_vien_huy
    ADD FOREIGN KEY (phong_ban_id) REFERENCES phong_ban_huy(id);

--3 Insert data
insert into loai_sach_huy values(1,'LS001','Sách văn học');
insert into loai_sach_huy values(2,'LS002','Sách kinh tế');
insert into loai_sach_huy values(3,'LS003','Sách kỹ năng');
insert into loai_sach_huy values(4,'LS004','Sách thiếu nhi');
insert into loai_sach_huy values(5,'LS005','Sách giáo khoa');
insert into loai_sach_huy values(6,'LS006','Sách tham khảo');
insert into loai_sach_huy values(7,'LS007','Sách ngoại ngữ');
insert into loai_sach_huy values(8,'LS008','Sách tự nhiên');
insert into loai_sach_huy values(9,'LS009','Sách lịch sử');
insert into loai_sach_huy values(10,'LS010','Sách văn hóa');

insert into sach_huy values(1,1,'S001','Ngữ Văn ','A');
insert into sach_huy values(2,3,'S002','Kỹ năng sống ','A');
insert into sach_huy values(3,2,'S003','Kinh tế học ','A');
insert into sach_huy values(4,1,'S004','Sách văn học 4','A');
insert into sach_huy values(5,1,'S005','Sách văn học 5','A');
insert into sach_huy values(6,1,'S006','Sách văn học 6','A');
insert into sach_huy values(7,1,'S007','Sách văn học 7','A');
insert into sach_huy values(8,1,'S008','Sách văn học 8','A');
insert into sach_huy values(9,1,'S009','Sách văn học 9','A');
insert into sach_huy values(10,1,'S010','Sách văn học 10','A');

insert into phong_ban_huy values(1,'PB001','Phòng kế toán','0');
insert into phong_ban_huy values(2,'PB002','Phòng nhân sự','1');
insert into phong_ban_huy values(3,'PB003','Phòng kỹ thuật','0');
insert into phong_ban_huy values(4,'PB004','Phòng hành chính','0');
insert into phong_ban_huy values(5,'PB005','Phòng kinh doanh','0');

insert into nhan_vien_huy values(1,1,'NV001','Nguyễn Văn A','A');
insert into nhan_vien_huy values(2,2,'NV002','Nguyễn Văn B','A');
insert into nhan_vien_huy values(3,3,'NV003','Nguyễn Văn C','A');
insert into nhan_vien_huy values(4,4,'NV004','Nguyễn Văn D','A');
insert into nhan_vien_huy values(5,5,'NV005','Nguyễn Văn E','A');
insert into nhan_vien_huy values(6,1,'NV006','Nguyễn Văn F','A');
insert into nhan_vien_huy values(7,2,'NV007','Nguyễn Văn G','A');
insert into nhan_vien_huy values(8,3,'NV008','Nguyễn Văn H','A');
insert into nhan_vien_huy values(9,4,'NV009','Nguyễn Văn I','A');
insert into nhan_vien_huy values(10,5,'NV010','Nguyễn Văn J','A');


insert into muon_sach_huy values(1,1,1,sysdate,'A',sysdate);
insert into muon_sach_huy values(2,2,2,sysdate,'A',sysdate);
insert into muon_sach_huy values(3,3,3,sysdate,'A',sysdate);
insert into muon_sach_huy values(4,4,4,sysdate,'A',sysdate);
insert into muon_sach_huy values(5,5,5,sysdate,'A',sysdate);
insert into muon_sach_huy values(6,6,6,sysdate,'A',sysdate);
insert into muon_sach_huy values(7,7,7,sysdate,'A',sysdate);
insert into muon_sach_huy values(8,2,4,sysdate,'A',sysdate);

update muon_sach_huy set ngay_tra = ADD_MONTHS(sysdate, 1) where id = 7;

--B

/*1: Thống kê tổng số lượt mượn sách, mỗi lần mượn sách được tính
  là một lượt(một bản ghi trong bảng muon sach) trong một khoảng thời gian fromDate, toDate */
select count(nhan_vien_id) as tong_so_luot_muon from muon_sach_huy
    where ngay_muon between '01-06-2022' and '31-12-2022';

/* 2: Thống kê số lượt mượn sách theo loại sách đầu ra ví dụ như,cách tính lượt mượn như BT1,
   trong khoảng thời gian từ FromDate, ToDate
        Loại sách, Lượt mượn, tỷ lệ
        Sách Java, 15, 30%
        Sách SQL 35, 70%  */

select ls.name, count(ms.id) as luot_muon, count(ms.id)*100/(select count(*) from muon_sach_huy) ||'%' as ty_le
from muon_sach_huy ms, sach_huy s, loai_sach_huy ls
where ms.sach_id = s.id and s.loai_sach_id = ls.id and ngay_muon between '01-06-2022' and '31-12-2022'
group by ls.name

/*   3: Thống kê số lượng nhân viên mượn sách trong khoảng thời gian từ formDate, ToDate(Trong khoảng thời gian một nhân viên mượn 100 cuốn cũng tính là một)
        Đầu ra : Chỉ hiện thì số lượng ví dụ 100(tức là trong khoảng thời gian đó có 100 nhân viên mượn)  */

select count(distinct nhan_vien_id) as so_luong_nhan_vien_muon from muon_sach_huy
    where ngay_muon between '01-06-2022' and '31-12-2022';

/*    4: Thống kê 10 phòng ban có lượt mượn nhiều nhất trong một khoảng thời gian FromDate, ToDate
        Đầu ra : Phòng ban 1, 100
                 Phòng ban 2, 50 */

select pb.name, count(ms.id) as luot_muon
from muon_sach_huy ms, nhan_vien_huy nv, phong_ban_huy pb
where ms.nhan_vien_id = nv.id and nv.phong_ban_id = pb.id and ROWNUM <= 10
group by pb.name order by luot_muon desc

/* 5 : Thông kê 10 nhân viên có lượt mượn nhiều nhất trong một khoảng thời gian fromDate, toDate
        Đầu ra : Mã nhân viên, Tên nhân viên, tên phong ban, lượt mượn, tỉ lệ %
                 NH01, Nguyễn Văn A, Phòng ban 1, 50, 20%
                 NH02, Nguyễn Văn B, Phòng ban 2, 25, 10% */

select nv.code, nv.name, pb.name, count(ms.id) as luot_muon, count(ms.id)*100/(select count(*) from muon_sach_huy) ||'%' as ty_le
from muon_sach_huy ms, nhan_vien_huy nv, phong_ban_huy pb
where ms.nhan_vien_id = nv.id and nv.phong_ban_id = pb.id and ROWNUM <= 10
group by nv.code, nv.name, pb.name order by luot_muon desc


--C
--3 tạo một view tên là v_nhan_vien_sach_tên của mình hiển thị được đầy đủ mã nhân viên, tên nhân viên, mã phòng ban, tên phong ban, mã sách, tên sách, ngày mượn, ngày trả
create  view v_nhan_vien_sach_huy as
select nv.code as ma_nv, nv.name as name_nv, pb.name as name_pb, s.code as ma_sach, s.name as name_sach, ms.ngay_muon, ms.ngay_tra
from muon_sach_huy ms, nhan_vien_huy nv, phong_ban_huy pb, sach_huy s
where ms.nhan_vien_id = nv.id and nv.phong_ban_id = pb.id and ms.sach_id = s.id;


-- 4 : Viết câu lệnh đổi trạng thái của trường status trong bảng muon_sach sang thành number, khi nào câu lệnh sẽ bị lỗi(không đổi datatype được)
ALTER TABLE muon_sach_huy
MODIFY status number(1);

create index idx on sach_huy(code);

--select index
select * from ALL_INDEXES
where TABLE_NAME = 'sach_huy';

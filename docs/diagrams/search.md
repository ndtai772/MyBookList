```mermaid
sequenceDiagram
    Actor A as Người dùng
    participant B as Ứng dụng
    participant C as Hệ thống
    participant D as CSDL Sách

    A ->>+ B: Từ khóa tìm kiếm
    B ->>+ C: Gửi truy vấn tìm kiếm
    C ->>+ D: Tìm kiếm sách phù hợp với từ khóa 
    D ->>- C: Dữ liệu tài khoản tương ứng
    C ->>- B: Danh sách sách sách khớp
    B ->>- A: Hiển thị kết quả tìm kiếm
```

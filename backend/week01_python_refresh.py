students = [
{"id": "22000001", "name": "Nguyen Minh Anh", "major": "KHDL"},
{"id": "22000002", "name": "Tran Duc Long", "major": "KHDL"},
]
courses = [
{
"code": "INT2204",
"name": "Co so du lieu Web va he thong thong tin",
"capacity": 3,
"enrolled": 2,
},
{
"code": "INT2205",
"name": "Khai pha du lieu",
"capacity": 2,
"enrolled": 2,
},
]
enrollments = [
{"student_id": "22000001", "course_code": "INT2204"}
]

def find_course(course_code):
    for course in courses:
        if course["code"] == course_code:
            return course
    return None


def find_student(student_id):
    for student in students:
        if student["id"] == student_id:
            return student
    return None


def enroll_student(student_id, course_code):

    if find_student(student_id) is None:
        return "Khong tim thay sinh vien"

    course = find_course(course_code)
    if course is None:
        return "Khong tim thay hoc phan"

    if course["enrolled"] >= course["capacity"]:
        return "Lop da du so luong"

    duplicated = any(
        item["student_id"] == student_id
        and item["course_code"] == course_code
        for item in enrollments
    )

    if duplicated:
        return "Sinh vien da dang ky hoc phan nay"

    enrollments.append({
        "student_id": student_id,
        "course_code": course_code
    })

    course["enrolled"] += 1

    return "Dang ky thanh cong"


print("1. Dang ky thanh cong:")
print(enroll_student("22000002", "INT2204"))

print("\n2. Dang ky trung:")
print(enroll_student("22000001", "INT2204"))

print("\n3. Lop day:")
print(enroll_student("22000002", "INT2205"))

print("\n4. Ma hoc phan khong ton tai:")
print(enroll_student("22000002", "INT9999"))

print("\n5. Ma sinh vien khong ton tai:")
print(enroll_student("22000099", "INT2204"))
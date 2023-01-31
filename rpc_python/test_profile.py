import ctypes

my_faker_lib = ctypes.CDLL("./faker.dll")
my_faker_lib.FakeAProfile.restype = ctypes.c_uint64
res = ctypes.string_at(my_faker_lib.FakeAProfile(True))

print(res.decode('utf-8'))

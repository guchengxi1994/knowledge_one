from typing import List
from faker.providers import (address, bank, barcode, color, company,
                             credit_card, currency, file, geo, internet, isbn,
                             job, lorem, person, phone_number, ssn, user_agent)
from faker import Faker
import ctypes

my_faker_lib = ctypes.CDLL("./faker.dll")
my_faker_lib.FakeAProfile.restype = ctypes.c_uint64


class CountCannotBeNegtiveException(Exception):
    ...


__providers__ = {
    "address": address,
    # "automotive": automotive,
    "bank": bank,
    "barcode": barcode,
    "color": color,
    "company": company,
    "credit_card": credit_card,
    "currency": currency,
    # "date_time": date_time,
    "file": file,
    "geo": geo,
    "internet": internet,
    "isbn": isbn,
    "job": job,
    "lorem": lorem,
    # "misc": misc,
    "person": person,
    "phone_number": phone_number,
    "ssn": ssn,
    "user_agent": user_agent,
    "profile": None
}


class ProviderMap:
    def __init__(self, key: str, value: str) -> None:
        self.key = key
        self.value = value


class FakerGenerator:
    def __init__(self,
                 providers: List[ProviderMap] = [],
                 locale: str = "zh_CN",
                 **kwargs) -> None:
        self.f = Faker(locale)
        self.pm = providers

        for i in self.pm:
            __p = __providers__.get(i.value, None)
            if __p is not None:
                self.f.add_provider(__p)

            if i == "person" or i == "profile":
                self.__gender = kwargs.get("gender", "unknow")

    def generate(self, times: int = 1) -> dict:
        if times < 1:
            raise CountCannotBeNegtiveException("次数需为正数")
        result = {}
        result['data'] = []
        for _ in range(0, times):
            __d = {}
            for j in self.pm:
                __d[j.key] = generate(self, j.value)
            result["data"].append(__d)
        return result

    @staticmethod
    def quick_fake(
        provider: str,
        locale: str = "zh_CN",
    ) -> str:
        __f = FakerGenerator(providers=[ProviderMap("test", provider)],
                             locale=locale)
        __p = __providers__.get(provider, None)
        __f.f.add_provider(__p)
        return generate(__f, provider)


def generate(f: FakerGenerator, c: str) -> str:
    if c == "profile":
        if not hasattr(f, "__gender"):
            __gender = True
        else:
            if f.__gender == "male":
                __gender = True
            else:
                __gender = False
        res = ctypes.string_at(my_faker_lib.FakeAProfile())
        return res.decode('utf-8')

    if c == "person":
        if not hasattr(f, "__gender"):
            __gender = "unknow"
        else:
            __gender = f.__gender

        if __gender == "unknow":
            return f.f.name()

        if __gender == "male":
            return f.f.name_male()

        if __gender == "female":
            return f.f.name_female()

        return "张三"

    if c == "address":
        return f.f.address()

    if c == "bank":
        return f.f.aba()

    if c == "barcode":
        return f.f.ean13()

    if c == "color":
        return f.f.color_name()

    if c == "company":
        return f.f.company()

    if c == "credit_card":
        return f.f.credit_card_number()

    if c == "currency":
        return str(f.f.currency())

    if c == "file":
        return f.f.file_name()

    if c == "geo":
        return "{},{}".format(f.f.latitude(), f.f.longitude())

    if c == "internet":
        return f.f.ipv4()

    if c == "isbn":
        return f.f.isbn13()

    if c == "job":
        return f.f.job()

    if c == "lorem":
        return f.f.sentence()

    if c == "phone_number":
        return f.f.phone_number()

    if c == "ssn":
        return f.f.ssn()

    if c == "user_agent":
        return f.f.chrome()

    return "???"
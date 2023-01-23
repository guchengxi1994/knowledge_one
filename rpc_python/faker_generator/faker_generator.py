from typing import List
from faker.providers import (address, bank, barcode, color, company,
                             credit_card, currency, file, geo, internet, isbn,
                             job, lorem, person, phone_number, ssn, user_agent)
from faker import Faker


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
    "user_agent": user_agent
}


class FakerGenerator:
    def __init__(self,
                 providers: List[str] = [],
                 locale: str = "zh_CN",
                 **kwargs) -> None:
        self.f = Faker(locale)
        self.keys = providers

        for i in providers:
            __p = __providers__.get(i, None)
            if __p is not None:
                self.f.add_provider(__p)

            if i == "person":
                self.__gender = kwargs.get("gender", "unknow")

    def generate(self, times: int = 1) -> dict:
        if times < 1:
            raise CountCannotBeNegtiveException("次数需为正数")
        result = {}
        result['data'] = []
        for i in range(0, times):
            __d = {}
            for j in self.keys:
                __d[j] = self.__generate(j)
            result["data"].append(__d)
        return result

    def __generate(self, c: str) -> str:
        if c == "person":
            if not hasattr(self, "__gender"):
                self.__gender = "unknow"

            if self.__gender == "unknow":
                return self.f.name()

            if self.__gender == "male":
                return self.f.name_male()

            if self.__gender == "female":
                return self.f.name_female()

            return "张三"

        if c == "address":
            return self.f.address()

        if c == "bank":
            return self.f.aba()

        if c == "barcode":
            return self.f.ean13()

        if c == "color":
            return self.f.color_name()

        if c == "company":
            return self.f.company()

        if c == "credit_card":
            return self.f.credit_card_number()

        if c == "currency":
            return str(self.f.currency())

        if c == "file":
            return self.f.file_name()

        if c == "geo":
            return "{},{}".format(self.f.latitude(), self.longitude())

        if c == "internet":
            return self.f.ipv4()

        if c == "isbn":
            return self.f.isbn13()

        if c == "job":
            return self.f.job()

        if c == "lorem":
            return self.f.sentence()

        if c == "phone_number":
            return self.f.phone_number()

        if c == "ssn":
            return self.f.ssn()

        if c == "user_agent":
            return self.f.chrome()

        return "???"
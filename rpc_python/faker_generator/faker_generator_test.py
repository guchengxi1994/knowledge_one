from faker_generator import FakerGenerator, ProviderMap

f = FakerGenerator(providers=[
    ProviderMap("地址", "address"),
    ProviderMap("银行", "bank"),
    ProviderMap("barcode", "barcode"),
    ProviderMap("颜色", "color"),
    ProviderMap("公司", "company"),
    ProviderMap("信用卡", "credit_card"),
    ProviderMap("currency", "currency"),
    ProviderMap("文件", "file"),
    ProviderMap("经纬度", "geo"),
    ProviderMap("网络", "internet"),
    ProviderMap("isbn", "isbn"),
    ProviderMap("职位", "job"),
    ProviderMap("随即文本", "lorem"),
    ProviderMap("人名", "person"),
    ProviderMap("手机号码", "phone_number"),
    ProviderMap("ssn", "ssn"),
    ProviderMap("user_agent", "user_agent")
])

print(f.generate())
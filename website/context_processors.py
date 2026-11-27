COLLEGE = {
    "name": "NCET Autonomous",
    "full_name": "NCET College (NCET Autonomous), Bhubaneswar",
    "short": "NCET",
    "tagline": "An Autonomous Institution with A++ Grade by NAAC, UGC | Approved by UGC / AICTE / Govt. of Odisha",
    "established": 2007,
    "address": "At: Gramadiha, P.O.: Gangapada, Bhubaneswar, Khurda, Odisha - 752054, India",
    "address_short": "Gramadiha, Gangapada, Bhubaneswar - 752054",
    "city_office": "B-004, Krishna Tower, Bhubaneswar",
    "phone": "+91 78730 08163",
    "phone_raw": "+917873008163",
    "email": "info@ncet.edu.in",
    "map_embed": "https://maps.google.com/maps?q=NCET%20Institute%20of%20Technology%20Bhubaneswar&t=&z=14&ie=UTF8&iwloc=&output=embed",
    "logo": "brand/logo.png",
    "social": {
        "facebook": "https://www.facebook.com/ncetbbsr",
        "twitter": "https://twitter.com/ncetbbsr",
        "youtube": "https://www.youtube.com/@ncetautonomous",
        "linkedin": "https://www.linkedin.com/school/ncet-bhubaneswar/",
        "instagram": "https://www.instagram.com/ncetbbsr/",
    },
    "about": (
        "Founded in 2007 by Balaram Panda Trust, NCET Autonomous is the only engineering college in Odisha "
        "accredited with NAAC A++ grade. Approved by UGC / AICTE and accredited by NBA, IAO "
        "and recognised by SIRO, Ministry of Science & Technology, Govt. of India."
    ),
}


def college(request):
    return {"college": COLLEGE}

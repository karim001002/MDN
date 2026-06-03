// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

// Copyright (c) 2026 Karim Asaad Qabil. All rights reserved.
// Licensed under the MIT License.

class MedicalSpecialties {
  static const List<Map<String, dynamic>> data = [
    {
      'id': 'internal_medicine',
      'names': {'en': 'Internal Medicine', 'ar': 'الطب الباطني'},
      'sub_specialties': [
        {'en': 'Cardiology', 'ar': 'أمراض القلب'},
        {'en': 'Gastroenterology', 'ar': 'أمراض الجهاز الهضمي'},
        {'en': 'Endocrinology', 'ar': 'الغدد الصماء'},
        {'en': 'Nephrology', 'ar': 'أمراض الكلى'},
        {'en': 'Pulmonology', 'ar': 'أمراض الصدر'},
        {'en': 'Rheumatology', 'ar': 'الروماتيزم'},
        {'en': 'Hematology', 'ar': 'أمراض الدم'},
        {'en': 'Infectious Diseases', 'ar': 'الأمراض المعدية'},
      ]
    },
    {
      'id': 'surgery',
      'names': {'en': 'Surgery', 'ar': 'الجراحة'},
      'sub_specialties': [
        {'en': 'General Surgery', 'ar': 'الجراحة العامة'},
        {'en': 'Orthopedic Surgery', 'ar': 'جراحة العظام'},
        {'en': 'Neurosurgery', 'ar': 'جراحة المخ والأعصاب'},
        {'en': 'Plastic Surgery', 'ar': 'جراحة التجميل'},
        {'en': 'Cardiothoracic Surgery', 'ar': 'جراحة القلب والصدر'},
        {'en': 'Pediatric Surgery', 'ar': 'جراحة الأطفال'},
        {'en': 'Vascular Surgery', 'ar': 'جراحة الأوعية الدموية'},
        {'en': 'Urology', 'ar': 'المسالك البولية'},
      ]
    },
    {
      'id': 'pediatrics',
      'names': {'en': 'Pediatrics', 'ar': 'طب الأطفال'},
      'sub_specialties': [
        {'en': 'Neonatology', 'ar': 'طب حديثي الولادة'},
        {'en': 'Pediatric Cardiology', 'ar': 'قلب الأطفال'},
        {'en': 'Pediatric Oncology', 'ar': 'أورام الأطفال'},
        {'en': 'Pediatric Emergency', 'ar': 'طوارئ الأطفال'},
      ]
    },
    {
      'id': 'obstetrics_gynecology',
      'names': {'en': 'Obstetrics & Gynecology', 'ar': 'النساء والتوليد'},
      'sub_specialties': [
        {'en': 'Fetal Medicine', 'ar': 'طب الجنين'},
        {'en': 'Reproductive Endocrinology', 'ar': 'تأخر الإنجاب والخصوبة'},
        {'en': 'Gynecologic Oncology', 'ar': 'أورام النساء'},
      ]
    },
    {
      'id': 'ophthalmology',
      'names': {'en': 'Ophthalmology', 'ar': 'طب وجراحة العيون'},
      'sub_specialties': [
        {'en': 'Retina', 'ar': 'الشبكية'},
        {'en': 'Cornea', 'ar': 'القرنية'},
        {'en': 'Glaucoma', 'ar': 'المياه الزرقاء'},
        {'en': 'Pediatric Ophthalmology', 'ar': 'عيون الأطفال'},
      ]
    },
    {
      'id': 'dermatology',
      'names': {'en': 'Dermatology', 'ar': 'الجلدية'},
      'sub_specialties': [
        {'en': 'Cosmetic Dermatology', 'ar': 'الجلدية التجميلية'},
        {'en': 'Dermatopathology', 'ar': 'أمراض الجلد'},
        {'en': 'Laser Treatment', 'ar': 'العلاج بالليزر'},
      ]
    },
    {
      'id': 'psychiatry',
      'names': {'en': 'Psychiatry', 'ar': 'الطب النفسي'},
      'sub_specialties': [
        {'en': 'Child & Adolescent Psychiatry', 'ar': 'نفسية الأطفال والمراهقين'},
        {'en': 'Addiction Psychiatry', 'ar': 'علاج الإدمان'},
        {'en': 'Geriatric Psychiatry', 'ar': 'نفسية المسنين'},
      ]
    },
    {
      'id': 'dentistry',
      'names': {'en': 'Dentistry', 'ar': 'طب الأسنان'},
      'sub_specialties': [
        {'en': 'Orthodontics', 'ar': 'تقويم الأسنان'},
        {'en': 'Endodontics', 'ar': 'علاج الجذور'},
        {'en': 'Oral & Maxillofacial Surgery', 'ar': 'جراحة الفم والفكين'},
        {'en': 'Pediatric Dentistry', 'ar': 'أسنان الأطفال'},
        {'en': 'Periodontics', 'ar': 'أمراض اللثة'},
      ]
    },
    {
      'id': 'ent',
      'names': {'en': 'ENT (Otolaryngology)', 'ar': 'الأنف والأذن والحنجرة'},
      'sub_specialties': [
        {'en': 'Rhinology', 'ar': 'أمراض الأنف والجيوب الأنفية'},
        {'en': 'Otology', 'ar': 'أمراض الأذن'},
        {'en': 'Laryngology', 'ar': 'أمراض الحنجرة'},
      ]
    }
  ];
}

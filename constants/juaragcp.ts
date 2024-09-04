export interface Course {
  name: string;
  url: string;
  type: string;
  category: string[];
  difficulty: string;
  duration: number;
  labs: number;
  earned?: Date;
  valid?: boolean;
}

export interface Badge {
  name: string;
  url: string;
  
}

export interface ProfileMeta {
  name: string;

}

export const s10: Course[] = [
  // Skill Badges AI/ML
  {
    name: 'Classify Images with TensorFlow on Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/646',
    type: 'skill',
    category: ['ai', 'ml'],
    difficulty: 'intermediate',
    duration: 435,
    labs: 6,
  },
  {
    name: 'Build LookML Objects in Looker',
    url: 'https://www.cloudskillsboost.google/course_templates/639',
    type: 'skill',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 315,
    labs: 5,
  },
  {
    name: 'Detect Manufacturing Defects using Visual Inspection AI',
    url: 'https://www.cloudskillsboost.google/course_templates/644',
    type: 'skill',
    category: ['ai', 'ml'],
    difficulty: 'intermediate',
    duration: 435,
    labs: 5,
  },
  {
    name: 'Analyze Speech and Language with Google APIs',
    url: 'https://www.cloudskillsboost.google/course_templates/634',
    type: 'skill',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 165,
    labs: 4,
  },
  {
    name: 'Analyze Images with the Cloud Vision API',
    url: 'https://www.cloudskillsboost.google/course_templates/633',
    type: 'skill',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 180,
    labs: 4,
  },
  {
    name: 'Analyze Sentiment with Natural Language API',
    url: 'https://www.cloudskillsboost.google/course_templates/667',
    type: 'skill',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 180,
    labs: 4,
  },
  {
    name: 'Perform Predictive Data Analysis in BigQuery',
    url: 'https://www.cloudskillsboost.google/course_templates/656',
    type: 'skill',
    category: ['ai', 'ml'],
    difficulty: 'intermediate',
    duration: 285,
    labs: 5,
  },
  {
    name: 'Create ML Models with BigQuery ML',
    url: 'https://www.cloudskillsboost.google/course_templates/626',
    type: 'skill',
    category: ['ai', 'ml'],
    difficulty: 'intermediate',
    duration: 330,
    labs: 5,
  },
  // Regular
  {
    name: 'Baseline: Data, ML, AI',
    url: 'https://www.cloudskillsboost.google/course_templates/619',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 300,
    labs: 6,
  },
  {
    name: 'Intro to ML: Language Processing',
    url: 'https://www.cloudskillsboost.google/course_templates/740',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 240,
    labs: 5,
  },
  {
    name: 'Intro to ML: Image Processing',
    url: 'https://www.cloudskillsboost.google/course_templates/739',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 285,
    labs: 5,
  },
  {
    name: 'Generative AI Explorer - Vertex AI',
    url: 'https://www.cloudskillsboost.google/course_templates/723',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 255,
    labs: 3,
  },
  {
    name: 'Google Cloud Computing Foundations: Data, ML, and AI in Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/156',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 480,
    labs: 5,
  },
  {
    name: 'Managing Machine Learning Projects with Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/157',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 1440,
    labs: 4,
  },
  {
    name: 'Introduction to AI and Machine Learning on Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/593',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 480,
    labs: 4,
  },
  {
    name: 'Google Cloud Big Data and Machine Learning Fundamentals',
    url: 'https://www.cloudskillsboost.google/course_templates/3',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 300,
    labs: 4,
  },
  {
    name: 'Applying Machine Learning to your Data with Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/23',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 960,
    labs: 4,
  },
  {
    name: 'Production Machine Learning Systems',
    url: 'https://www.cloudskillsboost.google/course_templates/17',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'intermediate',
    duration: 960,
    labs: 7,
  },
  {
    name: 'Smart Analytics, Machine Learning, and AI on Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/55',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'intermediate',
    duration: 420,
    labs: 6,
  },
  {
    name: 'ML Pipelines on Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/191',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'advanced',
    duration: 795,
    labs: 6,
  },
  {
    name: 'Integrating Applications with Gemini 1.0 Pro on Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/980',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 105,
    labs: 1,
  },
  {
    name: 'Gemini for Data Scientists and Analysts',
    url: 'https://www.cloudskillsboost.google/course_templates/879',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 120,
    labs: 2,
  },
  {
    name: 'Gemini for Application Developers',
    url: 'https://www.cloudskillsboost.google/course_templates/881',
    type: 'regular',
    category: ['ai', 'ml'],
    difficulty: 'introductory',
    duration: 90,
    labs: 1,
  },
  // Skill Badges Infrastructure & Security
  {
    name: 'Create and Manage AlloyDB Instances',
    url: 'https://www.cloudskillsboost.google/course_templates/642',
    type: 'skill',
    category: ['infrastructure', 'security'],
    difficulty: 'introductory',
    duration: 570,
    labs: 6,
  },
  {
    name: 'Create and Manage Cloud SQL for PostgreSQL Instances',
    url: 'https://www.cloudskillsboost.google/course_templates/652',
    type: 'skill',
    category: ['infrastructure', 'security'],
    difficulty: 'introductory',
    duration: 270,
    labs: 5,
  },
  {
    name: 'Monitor and Manage Google Cloud Resources',
    url: 'https://www.cloudskillsboost.google/course_templates/653',
    type: 'skill',
    category: ['infrastructure', 'security'],
    difficulty: 'introductory',
    duration: 180,
    labs: 5,
  },
  {
    name: 'Manage Kubernetes in Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/783',
    type: 'skill',
    category: ['infrastructure', 'security'],
    difficulty: 'intermediate',
    duration: 300,
    labs: 4,
  },
  {
    name: 'Build Infrastructure with Terraform on Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/636',
    type: 'skill',
    category: ['infrastructure', 'security'],
    difficulty: 'intermediate',
    duration: 315,
    labs: 5,
  },
  // Regular
  {
    name: 'Security Best Practices in Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/87',
    type: 'regular',
    category: ['infrastructure', 'security'],
    difficulty: 'introductory',
    duration: 675,
    labs: 7,
  },
  {
    name: 'Mitigating Security Vulnerabilities on Google Cloud',
    url: 'https://www.cloudskillsboost.google/course_templates/88',
    type: 'regular',
    category: ['infrastructure', 'security'],
    difficulty: 'introductory',
    duration: 300,
    labs: 4,
  },
];

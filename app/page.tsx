import { Course, s10 } from '@/constants/juaragcp';
import Link from 'next/link';
import { Form } from './form';
import { cookies } from 'next/headers';
import { Header } from '@/components/Header';
import { Hero } from '@/components/Hero';
import { Footer } from '@/components/Footer';

export default async function Home() {
  async function getProfileData(): Promise<{ name: string; earned: string }[] | null> {
    if (!cookies().has('id')) return null;
    const id = cookies().get('id');
    let badges: { name: string; earned: string }[] | null = null;
    const res = await fetch(
      `${process.env.API_BASE_URL}/csb_profile?id=${id?.value}`
    );
    if (res.ok) {
      const resJson = await res.json();
      badges = resJson.data.badges as { name: string; earned: string }[];
    }
    return badges;
  }
  const lower_limit = new Date('Aug 20, 2024 EDT');
  const upper_limit = new Date('Sep 15, 2024 EDT');
  const s10_names = s10.map((course) => course.name);
  const skill_badges = s10
    .filter((course) => course.type === 'skill')
    .map((course) => course.name);
  const regular_badges = s10
    .filter((course) => course.type === 'regular')
    .map((course) => course.name);

  let numberOfSkillBadges = 0;
  let numberOfRegularBadges = 0;
  let all: Course[] = s10;

  if (cookies().has('id')) {
    const id = cookies().get('id');
    let res = await fetch(
      `${process.env.API_BASE_URL}/csb_profile?id=${id?.value}`
    );

    let badges: { name: string; earned: string }[] | null | undefined = null;
    if (res.ok) {
      const resJson = await res.json();
      badges = resJson.data.badges as { name: string; earned: string }[] | undefined;
    }
    all = s10.map((course) => {
      if (badges === null || badges === undefined) return course;
      const earned = badges.filter(b => course.name === b.name)[0];
      if (earned === undefined) return course;
      course.earned = new Date(earned.earned);
      course.valid =
        course.earned >= lower_limit && course.earned <= upper_limit;
      if (course.type === 'skill' && course.valid) numberOfSkillBadges++;
      if (course.type === 'regular' && course.valid) numberOfRegularBadges++;
      return course;
    });
    // badges = badges.filter(badge => s10_names.includes(badge.name));
    // badges.map((badge) => {
    //   const earned = new Date(badge.earned);
    //   const dateCondition = earned >= lower_limit && earned <= upper_limit;
    //   if (skill_badges.includes(badge.name.trim()) && dateCondition) numberOfSkillBadges++;
    //   if (regular_badges.includes(badge.name.trim()) && dateCondition)
    //     numberOfRegularBadges++;
    //   let c = s10.filter((course) => course.name === badge.name)[0];
    //   if (c === null) return badge;
    //   c.earned = earned;
    //   c.valid = dateCondition;
    //   return c;
    // });
  }

  return (
    <div id="home">
      <Header />
      <main>
        <Hero />
        <div id="check" className="bg-neutral-900 py-16 mb-16">
          <div className="mx-auto max-w-6xl px-8">
            <div className="flex flex-col items-center justify-center mb-8">
              <h1 className="text-white text-2xl font-semibold">
                Let me check your profile
                {/* {data?.name ? `, ${data?.name}` : ''} */}
              </h1>
            </div>
            <div className="mb-16">
              <Form
                hasData={numberOfRegularBadges + numberOfSkillBadges !== 0}
              />
            </div>
            {numberOfRegularBadges + numberOfSkillBadges !== 0 ? (
              <div className="flex flex-col md:grid md:grid-cols-3 gap-8 text-white">
                <div className="flex flex-col rounded-3xl p-8 gap-4 ring-1 ring-zinc-900 bg-zinc-800">
                  <h2 className="text-6xl font-semibold">
                    {numberOfSkillBadges}
                  </h2>
                  <p className="text-base text-justify font-mono">
                    skill badge(s)
                  </p>
                </div>
                <div className="flex flex-col rounded-3xl p-8 gap-4 ring-1 ring-zinc-900 bg-zinc-800">
                  <h2 className="text-6xl font-semibold">
                    {numberOfSkillBadges + numberOfRegularBadges}
                  </h2>
                  <p className="text-base text-justify font-mono">
                    total badge(s)
                  </p>
                </div>
                <div className="flex flex-col rounded-3xl p-8 gap-4 ring-1 ring-zinc-900 bg-zinc-800">
                  <h2 className="text-6xl font-semibold">
                    {numberOfSkillBadges >= 7 && numberOfRegularBadges >= 9
                      ? '2'
                      : numberOfSkillBadges >= 4 && numberOfRegularBadges >= 6
                      ? '1'
                      : 'N/A'}
                  </h2>
                  <p className="text-base text-justify font-mono">
                    overall tier
                  </p>
                </div>
              </div>
            ) : (
              <></>
            )}
          </div>
        </div>
        <div className="mx-auto max-w-6xl px-8 mb-16">
          <div className="mb-8">
            <h1 className="text-2xl font-semibold mb-2">What's next?</h1>
            <p className="text-base">
              List of recommended badges for fastest challenge completion.
            </p>
          </div>
          <div className="flex flex-col md:grid md:grid-cols-4 gap-8">
            <div className="flex flex-col rounded-3xl p-6 gap-4 ring-1 ring-zinc-100 bg-zinc-50"></div>
          </div>
        </div>
        <div className="mx-auto max-w-6xl px-8 mb-16">
          <div className="mb-8">
            <div className="flex flex-row">
              <h1 className="text-2xl font-semibold">Badges</h1>
            </div>
          </div>
          <div className="flex flex-col md:grid md:grid-cols-3 gap-8">
            {s10
              .filter((course) => course.category[0] === 'infrastructure')
              .map((course, index) => (
                <div
                  key={index}
                  className="flex flex-col rounded-3xl p-6 gap-4 ring-1 ring-zinc-100 bg-zinc-50">
                  <div className="flex flex-row gap-4">
                    <div className="rounded-3xl px-4 bg-lime-200 font-semibold text-lime-800">
                      {course.type}
                    </div>
                  </div>
                  <div className="flex flex-row">
                    <Link href={course.url}>{course.name}</Link>
                    <div className="flex flex-grow"></div>
                  </div>
                  {/* <div className="flex flex-wrap gap-4">
                  <div key={index} className="rounded-xl px-4 bg-zinc-200">
                    {course.difficulty}
                  </div>
                  <div className="flex flex-row gap-4">
                    {course.category.map((c, index) => (
                      <div key={index} className="rounded-xl px-4 bg-zinc-200">
                        {c}
                      </div>
                    ))}
                  </div>
                </div> */}
                </div>
              ))}
          </div>
        </div>
      </main>
      <Footer />
    </div>
  );
}

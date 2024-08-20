import { s10 } from '@/constants/juaragcp';
import { Button } from '@headlessui/react';
import Image from 'next/image';
import Link from 'next/link';
import { Form } from './form';
import { cookies } from 'next/headers';
import { CheckCircleIcon } from '@heroicons/react/16/solid';

export default async function Home() {
  let res = new Response();
  let data = null;
  let skills = 0;
  let regulars = 0;

  if (cookies().has('id') && cookies().get('id')?.value) {
    const id = cookies().get('id');
    res = await fetch(
      `${process.env.API_BASE_URL}/csb_profile?id=${id?.value}`
    );

    if (res.ok) {
      data = (await res.json()).data;
    }

    const skill_badges = s10
      .filter((course) => course.type === 'skill')
      .map((badge) => badge.name);
    const regular_badges = s10
      .filter((course) => course.type === 'regular')
      .map((badge) => badge.name);

    const upper_limit = new Date('Sep 15, 2024 EDT');
    const lower_limit = new Date('Aug 20, 2024 EDT');
    const profileBadges = data.badges ?? [];

    profileBadges.map((badge: { name: string; earned: string }) => {
      const earnedDate = new Date(badge.earned);
      const dateCondition =
        earnedDate >= lower_limit && earnedDate <= upper_limit;
      if (skill_badges.includes(badge.name.trim()) && dateCondition) skills++;
      if (regular_badges.includes(badge.name.trim()) && dateCondition)
        regulars++;
      return badge;
    });
  }

  return (
    <div id="home">
      <nav className="inset-0 top-0 flex flex-row mx-auto max-w-6xl px-8 py-4 items-center mb-16">
        <span className="relative">
          <Image
            src={'/madebysownt.svg'}
            alt="made by sownt"
            width={128}
            height={16}
          />
        </span>
        <div className="flex flex-grow"></div>
        <span className="relative">
          <Link href={'https://github.com/sownt/study-jams'} target="_blank">
            <Image
              src="/github/github-mark.svg"
              alt="GitHub"
              width={24}
              height={24}
            />
          </Link>
        </span>
      </nav>
      <main>
        <div
          id="hero"
          className="mx-auto max-w-6xl flex flex-col md:flex-row px-8 gap-24 mb-16">
          <div className="flex flex-1 flex-col justify-center text-center items-center md:text-left md:items-start gap-4">
            <h1 className="text-2xl font-semibold">
              Google Cloud AI Study Jam: #JuaraGCP Season 10
            </h1>
            <p className="text-justify">
              <strong>#JuaraGCP</strong> is an online Google Cloud self-study
              program designed for developers in Indonesia. It provides access
              to hands-on Google Cloud labs and fosters learning through a
              supportive community of peers.
            </p>
            <div className="flex flex-row gap-4 items-center">
              <Link
                href={
                  'https://rsvp.withgoogle.com/events/juaragcp-s10/home_60f752'
                }
                target="_blank">
                <Button className="inline-flex items-center gap-2 rounded-md bg-zinc-900 py-1.5 px-3 text-sm/6 font-semibold text-white shadow-inner shadow-white/10 focus:outline-none data-[hover]:bg-gray-600 data-[open]:bg-gray-700 data-[focus]:outline-1 data-[focus]:outline-white">
                  Learn more
                </Button>
              </Link>
              <Link className="text-sm/6" href={'#check'}>
                Check your profile
              </Link>
            </div>
          </div>
          <div className="flex flex-1 flex-col items-end">
            <Image
              src={'/juara-gcp/juaragcp_s10_tier2.png'}
              alt="Juara GCP"
              width={1366}
              height={1005}
            />
          </div>
        </div>
        <div id="check" className="bg-neutral-900 py-16 mb-16">
          <div className="mx-auto max-w-6xl px-8">
            <div className="flex flex-col items-center justify-center mb-8">
              <h1 className="text-white text-2xl font-semibold">
                Let me check your profile{data?.name ? `, ${data?.name}` : ''}
              </h1>
              {data?.name ? <p className="text-white font-mono">{skills + regulars} badge(s) with {skills} skill badge(s)</p> : <></>}
            </div>
            <div className="mb-16">
              <Form />
            </div>
            <div className="flex flex-col md:grid md:grid-cols-3 gap-8 text-white">
              <div className="flex flex-col rounded-3xl p-8 gap-4 ring-1 ring-zinc-900 bg-zinc-800">
                <div className="flex flex-row gap-4 items-center">
                  <h2 className="text-xl font-semibold">Tier 1</h2>
                  {skills + regulars >= 10 && skills >= 4 ? (
                    <CheckCircleIcon className="w-4" />
                  ) : (
                    <></>
                  )}
                </div>
                <p className="text-base text-justify font-mono">
                  Snapback Hat, Sticker and Enamel Pin
                </p>
                <p className="text-base text-justify font-mono">
                  Complete at least 10 badges (including 4 skill badges) and a
                  quiz
                </p>
              </div>
              <div className="flex flex-col rounded-3xl p-8 gap-4 ring-1 ring-zinc-900 bg-zinc-800">
                <div className="flex flex-row gap-4 items-center">
                  <h2 className="text-xl font-semibold">Tier 2</h2>
                  {skills + regulars >= 16 && skills >= 7 ? (
                    <CheckCircleIcon className="w-4" />
                  ) : (
                    <></>
                  )}
                </div>
                <p className="text-base text-justify font-mono">
                  Snapback Hat, Sticker, Enamel Pin and Backpack
                </p>
                <p className="text-base text-justify font-mono">
                  Complete at least 16 badges (including 7 skill badges) and a
                  quiz
                </p>
              </div>
              <div className="flex flex-col rounded-3xl p-8 gap-4 ring-1 ring-zinc-900 bg-zinc-800">
                <h2 className="text-xl font-semibold">Quiz</h2>
                <p className="text-base text-justify font-mono">
                  An online quiz on either September 20 or 21, 2024. Details
                  about the quiz will be shared exclusively with eligible
                  participants who have earned the minimum required number of
                  badges between August 20 and September 15, 2024.
                </p>
              </div>
            </div>
          </div>
        </div>
        <div className="mx-auto max-w-6xl px-8 mb-16">
          <div className="mb-8">
            <h1 className="text-2xl font-semibold">Badges</h1>
          </div>
          <div className="flex flex-col md:grid md:grid-cols-3 gap-8">
            {s10.map((course, index) => (
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
                <div className="flex flex-wrap gap-4">
                  <div key={index} className="rounded px-4 bg-zinc-200">
                    {course.difficulty}
                  </div>
                  <div className="flex flex-row gap-4">
                    {course.category.map((c, index) => (
                      <div key={index} className="rounded px-4 bg-zinc-200">
                        {c}
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </main>
      <footer className="p-8 bg-zinc-600">
        <div className="mx-auto max-w-6xl flex flex-row text-white font-semibold justify-center">
          <Image
            src={'/madebysownt_white.svg'}
            alt="made by sownt"
            width={128}
            height={16}
          />
        </div>
      </footer>
    </div>
  );
}

'use client';
import { s10 } from '@/constants/juaragcp';
import { Button } from '@headlessui/react';
import Image from 'next/image';
import Link from 'next/link';
import { useRouter } from 'next/navigation';

export default function Home() {
  const router = useRouter();

  function learnMore() {
    router.push('https://rsvp.withgoogle.com/events/juaragcp-s10/home_60f752');
  }

  return (
    <div>
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
          <Image
            src="/github/github-mark.svg"
            alt="GitHub"
            width={24}
            height={24}
          />
        </span>
      </nav>
      <main>
        <div
          id="hero"
          className="mx-auto max-w-6xl flex flex-col md:flex-row px-8 gap-24">
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
              <Button
                className="inline-flex items-center gap-2 rounded-md bg-gray-700 py-1.5 px-3 text-sm/6 font-semibold text-white shadow-inner shadow-white/10 focus:outline-none data-[hover]:bg-gray-600 data-[open]:bg-gray-700 data-[focus]:outline-1 data-[focus]:outline-white"
                onClick={learnMore}>
                Learn more
              </Button>
              <Link className="text-sm/6" href={'#'}>
                Check your process
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
        <div className="mx-auto max-w-6xl px-8 grid grid-cols-2 md:grid-cols-3 gap-8">
          {s10.map((course, index) => (
            <div className="flex flex-col gap-4">
              <div className="">{course.type}</div>
              <div className="flex flex-row">
                <Link href={course.url}>{course.name}</Link>
                <div className="flex flex-grow"></div>
              </div>
              <div className="flex flex-row gap-4">
                <div>{course.difficulty}</div>
                <div>{course.duration}</div>
                <div className="flex flex-row gap-4">
                  {course.category.map((c, _) => (
                    <div>{c}</div>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>
      </main>
      <footer></footer>
    </div>
  );
}

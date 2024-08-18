'use client';
import { s10 } from '@/constants/juaragcp';
import { Button, Input } from '@headlessui/react';
import Image from 'next/image';
import Link from 'next/link';
import clsx from 'clsx';

export default function Home() {
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
              <Link href={'https://rsvp.withgoogle.com/events/juaragcp-s10/home_60f752'} target='_blank'>
                <Button
                  className="inline-flex items-center gap-2 rounded-md bg-gray-700 py-1.5 px-3 text-sm/6 font-semibold text-white shadow-inner shadow-white/10 focus:outline-none data-[hover]:bg-gray-600 data-[open]:bg-gray-700 data-[focus]:outline-1 data-[focus]:outline-white">
                  Learn more
                </Button>
              </Link>
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
        <div className="mx-auto max-w-6xl px-8 mb-16">
          <div className="flex flex-row items-center justify-center gap-4">
            <Input
              placeholder="Enter your profile url"
              className={clsx(
                'block rounded-lg border border-zinc-100 bg-zinc-50 py-1.5 text-zinc-500 px-3 text-sm/6',
                'focus:outline-5 data-[focus]:outline-2 data-[focus]:-outline-offset-2 data-[focus]:outline-white/25'
              )}
            />
            <Button
              className="inline-flex items-center gap-2 rounded-md bg-gray-700 py-1.5 px-3 text-sm/6 font-semibold text-white shadow-inner shadow-white/10 focus:outline-none data-[hover]:bg-gray-600 data-[open]:bg-gray-700 data-[focus]:outline-1 data-[focus]:outline-white">
              Check
            </Button>
          </div>
        </div>
        <div className="mx-auto max-w-6xl px-8 flex flex-col md:grid md:grid-cols-3 gap-8 mb-16">
          {s10.map((course, index) => (
            <div key={index} className="flex flex-col rounded-3xl p-6 gap-4 ring-1 ring-zinc-100 bg-zinc-50">
              <div className="flex flex-row gap-4">
                <div className="rounded-3xl px-4 bg-lime-200 font-semibold text-lime-800">{course.type}</div>
              </div>
              <div className="flex flex-row">
                <Link href={course.url}>{course.name}</Link>
                <div className="flex flex-grow"></div>
              </div>
              <div className="flex flex-wrap gap-4">
                <div>{course.difficulty}</div>
                <div className="flex flex-row gap-4">
                  {course.category.map((c, index) => (
                    <div key={index}>{c}</div>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>
      </main>
      <footer className="p-8 bg-zinc-600">
        <div className="mx-auto max-w-6xl flex flex-row text-white font-semibold justify-center">
          <span>made by sownt</span>
        </div>
      </footer>
    </div>
  );
}

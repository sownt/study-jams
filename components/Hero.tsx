import { Button } from '@headlessui/react';
import Image from 'next/image';
import Link from 'next/link';

export function Hero() {
  return (
    <div
      id="hero"
      className="mx-auto max-w-6xl flex flex-col md:flex-row px-8 gap-24 mb-16">
      <div className="flex flex-1 flex-col justify-center text-center items-center md:text-left md:items-start gap-4">
        <h1 className="text-2xl font-semibold">
          Google Cloud AI Study Jam: #JuaraGCP Season 10
        </h1>
        <p className="text-justify">
          <strong>#JuaraGCP</strong> is an online Google Cloud self-study
          program designed for developers in Indonesia. It provides access to
          hands-on Google Cloud labs and fosters learning through a supportive
          community of peers.
        </p>
        <div className="flex flex-row gap-4 items-center">
          <Link
            href={'https://rsvp.withgoogle.com/events/juaragcp-s10/home_60f752'}
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
  );
}

'use client';
import { Button, Input } from '@headlessui/react';
import clsx from 'clsx';
import { useRouter } from 'next/navigation';
import { useEffect, useState } from 'react';
import Cookies from 'universal-cookie';

export function Form(props: { hasData: boolean }) {
  const router = useRouter();
  const [profileUrl, setProfileUrl] = useState('');

  useEffect(() => {
    const cookies = new Cookies(null, { path: '/' });
    const id = cookies.get('id');
    if (id) {
      setProfileUrl(
        'https://www.cloudskillsboost.google/public_profiles/' + id
      );
    }
  }, []);

  function submit() {
    const match = profileUrl.match(/\/public_profiles\/([a-f0-9-]+)/i);
    const id = match ? match[1] : null;
    if (id === null) return;
    const cookies = new Cookies(null, { path: '/' });
    cookies.set('id', id);
    router.refresh();
  }

  function reset() {
    setProfileUrl('');
    const cookies = new Cookies(null, { path: '/' });
    cookies.remove('id');
    router.refresh();
  }

  return (
    <div className="flex flex-row items-center justify-center gap-4">
      <Input
        disabled={props.hasData}
        value={profileUrl}
        onChange={(e) => setProfileUrl(e.target.value)}
        placeholder="Enter your profile url"
        className={clsx(
          'block md:w-1/3 rounded-lg outline-2 outline-zinc-200 bg-zinc-50 py-1.5 text-zinc-500 px-3 text-sm/6',
          'focus:outline-5 data-[focus]:outline-2 data-[focus]:-outline-offset-2 data-[focus]:outline-zinc-200'
        )}
      />
      <Button
        disabled={
          profileUrl.match(/\/public_profiles\/([a-f0-9-]+)/i) === null ||
          profileUrl === ''
        }
        onClick={props.hasData ? reset : submit}
        className="inline-flex items-center gap-2 rounded-md bg-gray-700 py-1.5 px-3 text-sm/6 font-semibold text-white shadow-inner shadow-white/10 focus:outline-none data-[hover]:bg-gray-600 data-[open]:bg-gray-700 data-[focus]:outline-1 data-[focus]:outline-white">
        {profileUrl.match(/\/public_profiles\/([a-f0-9-]+)/i) ||
        profileUrl === ''
          ? props.hasData
            ? 'Reset'
            : 'Check'
          : 'Not available'}
      </Button>
    </div>
  );
}

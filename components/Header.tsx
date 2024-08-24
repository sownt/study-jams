import Image from 'next/image';
import Link from 'next/link';

export function Header() {
  return (
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
  );
}

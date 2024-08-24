import Image from 'next/image';

export function Footer() {
  return (
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
  );
}

import Link from 'next/link';

export default function BlogNavigation() {
  return (
    <nav>
      <ul>
        <li>
          <Link href="/blog">Blog Home</Link>
        </li>
        <li>
          <Link href="/blog/post-1">Post 1</Link>
        </li>
        <li>
          <Link href="/blog/post-2">Post 2</Link>
        </li>
        <li>
          <Link href="/blog/nested">Nested Blog</Link>
        </li>
      </ul>
    </nav>
  );
}
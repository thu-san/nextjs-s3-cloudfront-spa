import Link from 'next/link';

export default function NestedBlogNavigation() {
  return (
    <nav>
      <ul>
        <li>
          <Link href="/blog">Blog Home</Link>
        </li>
        <li>
          <Link href="/blog/nested">Nested Blog Home</Link>
        </li>
        <li>
          <Link href="/blog/nested/nested-1">Nested 1</Link>
        </li>
        <li>
          <Link href="/blog/nested/nested-2">Nested 2</Link>
        </li>
      </ul>
    </nav>
  );
}
import Link from 'next/link';
import { BlogPost } from '@/data/blog-posts';

interface BlogPostCardProps {
  post: BlogPost;
  basePath?: string;
}

export default function BlogPostCard({ post, basePath = '/blog' }: BlogPostCardProps) {
  const href = `${basePath}/${post.slug}`;
  
  return (
    <div>
      <Link href={href}>
        {post.title}
      </Link>
    </div>
  );
}
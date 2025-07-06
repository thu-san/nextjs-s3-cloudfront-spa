import { notFound } from 'next/navigation';
import BlogLayout from '../_components/BlogLayout';
import { getBlogPostBySlug, blogPosts } from '@/data/blog-posts';

interface BlogPostPageProps {
  params: Promise<{ slug: string }>;
}

export async function generateStaticParams() {
  return blogPosts.map((post) => ({
    slug: post.slug,
  }));
}

export default async function BlogPostPage({ params }: BlogPostPageProps) {
  const { slug } = await params;
  const post = getBlogPostBySlug(slug);
  
  if (!post || !blogPosts.find(p => p.slug === slug)) {
    notFound();
  }
  
  return (
    <BlogLayout>
      <h1>{post.title}</h1>
    </BlogLayout>
  );
}
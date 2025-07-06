import { notFound } from 'next/navigation';
import BlogLayout from '../../_components/BlogLayout';
import { getBlogPostBySlug, nestedBlogPosts } from '@/data/blog-posts';

interface NestedBlogPostPageProps {
  params: Promise<{ slug: string }>;
}

export async function generateStaticParams() {
  return nestedBlogPosts.map((post) => ({
    slug: post.slug,
  }));
}

export default async function NestedBlogPostPage({ params }: NestedBlogPostPageProps) {
  const { slug } = await params;
  const post = getBlogPostBySlug(slug);
  
  if (!post || !nestedBlogPosts.find(p => p.slug === slug)) {
    notFound();
  }
  
  return (
    <BlogLayout>
      <h1>{post.title}</h1>
    </BlogLayout>
  );
}